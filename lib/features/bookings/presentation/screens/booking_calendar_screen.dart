import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../properties/domain/entities/property.dart';

class BookingCalendarScreen extends StatefulWidget {
  const BookingCalendarScreen({super.key});

  @override
  State<BookingCalendarScreen> createState() => _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends State<BookingCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _numberOfGuests = 1;
  bool _bookingForSomeone = false;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_checkInDate == null || _checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select check-in and check-out dates'),
        ),
      );
      return;
    }

    if (_bookingForSomeone) {
      Navigator.pushNamed(
        context,
        '/booking-info',
        arguments: {
          'checkIn': _checkInDate,
          'checkOut': _checkOutDate,
          'numberOfGuests': _numberOfGuests,
          'noteToOwner': _noteController.text,
          'bookingForSomeone': _bookingForSomeone,
        },
      );
    } else {
      Navigator.pushNamed(
        context,
        '/booking-summary',
        arguments: {
          'checkIn': _checkInDate,
          'checkOut': _checkOutDate,
          'numberOfGuests': _numberOfGuests,
          'noteToOwner': _noteController.text,
          'bookingForSomeone': _bookingForSomeone,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final property = ModalRoute.of(context)?.settings.arguments as Property?;
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Calendar
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              rangeStartDay: _checkInDate,
              rangeEndDay: _checkOutDate,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                  if (_checkInDate == null || (_checkInDate != null && _checkOutDate != null)) {
                    _checkInDate = selectedDay;
                    _checkOutDate = null;
                  } else if (_checkInDate != null && _checkOutDate == null) {
                    if (selectedDay.isAfter(_checkInDate!)) {
                      _checkOutDate = selectedDay;
                    } else {
                      _checkInDate = selectedDay;
                    }
                  }
                });
              },
              selectedDayPredicate: (day) {
                if (_checkInDate != null && _checkOutDate != null) {
                  return day.isAfter(_checkInDate!.subtract(const Duration(days: 1))) &&
                      day.isBefore(_checkOutDate!.add(const Duration(days: 1)));
                }
                return isSameDay(_checkInDate, day) || isSameDay(_checkOutDate, day);
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                rangeHighlightColor: AppColors.primary.withValues(alpha: 0.1),
                rangeStartDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Booking Details
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Check-in / Check-out
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Check in',
                              style: AppTextStyles.heading3,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.md,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.border),
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 20),
                                  const SizedBox(width: AppSpacing.sm),
                                  Text(
                                    _checkInDate != null
                                        ? dateFormat.format(_checkInDate!)
                                        : 'Select',
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Check out',
                              style: AppTextStyles.heading3,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.md,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.border),
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 20),
                                  const SizedBox(width: AppSpacing.sm),
                                  Text(
                                    _checkOutDate != null
                                        ? dateFormat.format(_checkOutDate!)
                                        : 'Select',
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Number of Guests
                  const Text(
                    'Number of Guest',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Allowed Max ${property?.maxGuests ?? 30} Guest',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_numberOfGuests > 1) {
                            setState(() {
                              _numberOfGuests--;
                            });
                          }
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.remove, color: AppColors.primary, size: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                        child: Text(
                          _numberOfGuests.toString(),
                          style: AppTextStyles.heading2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_numberOfGuests < (property?.maxGuests ?? 30)) {
                            setState(() {
                              _numberOfGuests++;
                            });
                          }
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: AppColors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Note to Owner
                  const Text(
                    'Note to Owner (optional)',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Notes',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Booking for someone checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _bookingForSomeone,
                        onChanged: (value) {
                          setState(() {
                            _bookingForSomeone = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'Booking for someone',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handleContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: Text('Continue', style: AppTextStyles.button),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
