import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../properties/domain/entities/property.dart';
import '../../../properties/presentation/providers/property_provider.dart';

class ChatAssistantScreen extends StatefulWidget {
  const ChatAssistantScreen({super.key});

  @override
  State<ChatAssistantScreen> createState() => _ChatAssistantScreenState();
}

class _ChatAssistantScreenState extends State<ChatAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _isBotTyping = false;
  List<Property> _allProperties = [];

  final List<_QuickAction> _quickActions = [
    _QuickAction('Suggest apartments', '\u{1F3E2}'),
    _QuickAction('Cheapest properties', '\u{1F4B0}'),
    _QuickAction('Show villas', '\u{1F3D6}'),
    _QuickAction('Featured properties', '\u{2B50}'),
  ];

  final GlobalKey _addButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<PropertyProvider>();
      await provider.loadProperties();
      if (mounted) {
        _allProperties = provider.properties;
        _addBotMessage(
          'Hello! I\'m GoProperty AI assistant. I can help you find apartments, villas, and houses at the best prices. What are you looking for?',
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _addBotMessage(String text, {List<Property>? properties}) {
    setState(() {
      _messages.add(_ChatMessage(
        text: text,
        isUser: false,
        properties: properties,
      ));
    });
    _scrollToBottom();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _isBotTyping = true;
    });
    _messageController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _isBotTyping = false;
      });
      _generateBotResponse(text);
    });
  }

  void _generateBotResponse(String userMessage) {
    final msg = userMessage.toLowerCase();
    final currencyFormat =
        NumberFormat.currency(symbol: 'GH\u{20B5}', decimalDigits: 0);

    // Greetings
    if (msg.contains('hello') || msg.contains('hi') || msg.contains('hey')) {
      _addBotMessage(
        'Hey there! Looking for a place to stay? I can suggest apartments, villas, or houses. You can also ask me for the cheapest options!',
      );
      return;
    }

    // Cheapest / affordable / budget
    if (msg.contains('cheap') ||
        msg.contains('affordable') ||
        msg.contains('budget') ||
        msg.contains('low price') ||
        msg.contains('less pric')) {
      final sorted = List<Property>.from(_allProperties)
        ..sort((a, b) => a.price.compareTo(b.price));
      final cheapest = sorted.take(3).toList();

      if (cheapest.isEmpty) {
        _addBotMessage(
            'Sorry, I couldn\'t find any properties right now. Please try again later.');
        return;
      }

      _addBotMessage(
        'Here are the most affordable options I found for you:',
        properties: cheapest,
      );
      return;
    }

    // Apartments
    if (msg.contains('apartment')) {
      final apartments =
          _allProperties.where((p) => p.type == 'Apartment').toList();
      if (apartments.isEmpty) {
        _addBotMessage(
            'No apartments available at the moment. Want me to show villas or houses instead?');
        return;
      }
      _addBotMessage(
        'Here are the available apartments:',
        properties: apartments,
      );
      return;
    }

    // Villas
    if (msg.contains('villa')) {
      final villas = _allProperties.where((p) => p.type == 'Villa').toList();
      if (villas.isEmpty) {
        _addBotMessage(
            'No villas available right now. Would you like to see apartments or houses?');
        return;
      }
      _addBotMessage(
        'Here are the available villas:',
        properties: villas,
      );
      return;
    }

    // Houses
    if (msg.contains('house')) {
      final houses = _allProperties.where((p) => p.type == 'House').toList();
      if (houses.isEmpty) {
        _addBotMessage(
            'No houses available right now. Would you like to see apartments or villas?');
        return;
      }
      _addBotMessage(
        'Here are the available houses:',
        properties: houses,
      );
      return;
    }

    // Featured
    if (msg.contains('featured') ||
        msg.contains('best') ||
        msg.contains('top')) {
      final featured = _allProperties.where((p) => p.isFeatured).toList();
      if (featured.isEmpty) {
        _addBotMessage(
            'No featured properties found. Want me to show all available properties?');
        return;
      }
      _addBotMessage(
        'Here are our top featured properties:',
        properties: featured,
      );
      return;
    }

    // Location-based
    if (msg.contains('dubai') ||
        msg.contains('india') ||
        msg.contains('pune') ||
        msg.contains('poland') ||
        msg.contains('thailand')) {
      String searchTerm = '';
      if (msg.contains('dubai')) searchTerm = 'Dubai';
      if (msg.contains('india') || msg.contains('pune')) searchTerm = 'Pune';
      if (msg.contains('poland')) searchTerm = 'Poland';
      if (msg.contains('thailand')) searchTerm = 'Thailand';

      final locationProps = _allProperties
          .where((p) =>
              p.city.toLowerCase().contains(searchTerm.toLowerCase()) ||
              p.country.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      if (locationProps.isEmpty) {
        _addBotMessage(
            'I couldn\'t find properties in that area. Try asking for apartments, villas, or cheapest options.');
        return;
      }
      _addBotMessage(
        'Properties in $searchTerm:',
        properties: locationProps,
      );
      return;
    }

    // Show all / suggest / recommend
    if (msg.contains('all') ||
        msg.contains('show') ||
        msg.contains('suggest') ||
        msg.contains('recommend')) {
      if (_allProperties.isEmpty) {
        _addBotMessage(
            'No properties available right now. Please try again later.');
        return;
      }
      _addBotMessage(
        'Here are all available properties:',
        properties: _allProperties,
      );
      return;
    }

    // Price query
    if (msg.contains('price') ||
        msg.contains('cost') ||
        msg.contains('how much')) {
      if (_allProperties.isEmpty) {
        _addBotMessage('No properties loaded yet. Please try again.');
        return;
      }
      final sorted = List<Property>.from(_allProperties)
        ..sort((a, b) => a.price.compareTo(b.price));
      final cheapest = sorted.first;
      final mostExpensive = sorted.last;
      _addBotMessage(
        'Our prices range from ${currencyFormat.format(cheapest.price)}/${cheapest.priceType} '
        '(${cheapest.name}) to ${currencyFormat.format(mostExpensive.price)}/${mostExpensive.priceType} '
        '(${mostExpensive.name}). Want me to show the cheapest options?',
      );
      return;
    }

    // Thank you
    if (msg.contains('thank') || msg.contains('thanks')) {
      _addBotMessage(
          'You\'re welcome! Let me know if you need anything else.');
      return;
    }

    // Default
    _addBotMessage(
      'I can help you with:\n'
      '\u{2022} Finding apartments, villas, or houses\n'
      '\u{2022} Showing cheapest/affordable options\n'
      '\u{2022} Featured properties\n'
      '\u{2022} Properties by location (Dubai, India, etc.)\n'
      '\u{2022} Price ranges\n\n'
      'Try asking something like "Show me cheap apartments" or "Suggest villas"!',
    );
  }

  void _onPickImages() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening image picker...')),
    );
  }

  void _onRecordAudio() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening audio recorder...')),
    );
  }

  void _onUploadVideo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening video picker...')),
    );
  }

  void _onUploadFile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening file picker...')),
    );
  }

  void _showAttachmentOptions() {
    final RenderBox renderBox =
        _addButtonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy - 340,
        offset.dx + renderBox.size.width,
        offset.dy,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      color: AppColors.white,
      elevation: 4,
      items: [
        _buildPopupItem(Icons.photo_library_outlined, 'Add photos'),
        _buildPopupItem(Icons.camera_alt_outlined, 'Take photo'),
        _buildPopupItem(Icons.attach_file, 'Add files'),
        _buildPopupItem(Icons.mic_outlined, 'Record audio'),
        _buildPopupItem(Icons.videocam_outlined, 'Upload video'),
        _buildPopupItem(Icons.image_outlined, 'Create image'),
        _buildPopupItem(Icons.language, 'Web search'),
      ],
    ).then((value) {
      if (value == null || !mounted) return;
      switch (value) {
        case 'Add photos':
        case 'Take photo':
          _onPickImages();
          break;
        case 'Add files':
          _onUploadFile();
          break;
        case 'Record audio':
          _onRecordAudio();
          break;
        case 'Upload video':
          _onUploadVideo();
          break;
      }
    });
  }

  PopupMenuEntry<String> _buildPopupItem(IconData icon, String label) {
    return PopupMenuItem<String>(
      value: label,
      height: 48,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textPrimary),
          const SizedBox(width: AppSpacing.md),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF2C3E50),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'G',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GoProperty AI',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.success,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: _messages.isEmpty
                ? _buildWelcomeView()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: _messages.length + (_isBotTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _messages.length && _isBotTyping) {
                        return _buildTypingIndicator();
                      }
                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
          ),

          // Quick action chips (shown at start)
          if (_messages.length <= 1)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: _quickActions.map((action) {
                  return GestureDetector(
                    onTap: () {
                      _messageController.text = action.label;
                      _sendMessage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm + 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadius.round),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        '${action.label} ${action.emoji}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          // Input bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  GestureDetector(
                    key: _addButtonKey,
                    onTap: _showAttachmentOptions,
                    child: const Icon(
                      Icons.add,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(AppRadius.round),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Ask about properties...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.sm,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GestureDetector(
                    onTap: _onRecordAudio,
                    child: const Icon(
                      Icons.mic_none,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2C3E50),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFF2C3E50),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'G',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'GoProperty AI',
            style: AppTextStyles.heading2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Your personal property assistant',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    final isUser = message.isUser;
    final currencyFormat =
        NumberFormat.currency(symbol: 'GH\u{20B5}', decimalDigits: 0);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) ...[
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C3E50),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'G',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(AppRadius.lg),
                      topRight: const Radius.circular(AppRadius.lg),
                      bottomLeft: isUser
                          ? const Radius.circular(AppRadius.lg)
                          : Radius.zero,
                      bottomRight: isUser
                          ? Radius.zero
                          : const Radius.circular(AppRadius.lg),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isUser ? AppColors.white : AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Property cards from bot
          if (message.properties != null && message.properties!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                left: 36,
                top: AppSpacing.sm,
              ),
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: message.properties!.length,
                  itemBuilder: (context, index) {
                    final property = message.properties![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/property-detail',
                          arguments: property,
                        );
                      },
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(AppRadius.md),
                              ),
                              child: Image.asset(
                                property.images.first,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 100,
                                    color: AppColors.border,
                                    child: const Center(
                                      child: Icon(
                                        Icons.home,
                                        size: 40,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    property.name,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    property.fullLocation,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    property.priceType == 'night'
                                        ? '${currencyFormat.format(property.price)} /night'
                                        : currencyFormat
                                            .format(property.price),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFF2C3E50),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'G',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 600 + (index * 200)),
                  builder: (context, value, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary
                            .withValues(alpha: 0.3 + (value * 0.5)),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final List<Property>? properties;

  const _ChatMessage({
    required this.text,
    required this.isUser,
    this.properties,
  });
}

class _QuickAction {
  final String label;
  final String emoji;

  const _QuickAction(this.label, this.emoji);
}
