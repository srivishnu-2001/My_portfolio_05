// import 'package:flutter/material.dart';
// import '../constants.dart';
// import '../data.dart';
// import '../widgets/glass_card.dart';
// import '../widgets/animated_reveal.dart';

// class AboutSection extends StatelessWidget {
//   const AboutSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dark  = Theme.of(context).brightness == Brightness.dark;
//     final width = MediaQuery.of(context).size.width;
//     final isMobile = width < 750;

//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: isMobile ? 24 : 60, vertical: isMobile ? 50 : 80),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AnimatedReveal(
//             child: SectionHeader(label: 'Who I Am', title: 'About Me', dark: dark),
//           ),
//           const SizedBox(height: 44),
//           AnimatedReveal(
//             delay: const Duration(milliseconds: 150),
//             child: isMobile
//                 ? _buildMobileContent(dark)
//                 : _buildDesktopContent(dark),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDesktopContent(bool dark) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(flex: 5, child: _buildBio(dark)),
//         const SizedBox(width: 40),
//         Expanded(flex: 4, child: _buildStats(dark)),
//       ],
//     );
//   }

//   Widget _buildMobileContent(bool dark) {
//     return Column(
//       children: [
//         _buildBio(dark),
//         const SizedBox(height: 32),
//         _buildStats(dark),
//       ],
//     );
//   }

//   Widget _buildBio(bool dark) {
//     return GlassCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('My Story', style: AppTextStyles.cardTitle(dark)),
//           const SizedBox(height: 16),
//           Text(
//             PortfolioData.summary,
//             style: AppTextStyles.body(dark),
//           ),
//           const SizedBox(height: 24),
//           const Divider(),
//           const SizedBox(height: 16),
//           // Education list
//           ...PortfolioData.education.map(
//             (e) => Padding(
//               padding: const EdgeInsets.only(bottom: 14),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: AppColors.teal.withOpacity(0.12),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(Icons.school_outlined,
//                         color: AppColors.teal, size: 18),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(e['degree']!,
//                             style: AppTextStyles.cardTitle(dark)
//                                 .copyWith(fontSize: 13)),
//                         const SizedBox(height: 2),
//                         Text('${e['institute']}  •  ${e['year']}  •  ${e['grade']}',
//                             style: AppTextStyles.label(dark)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStats(bool dark) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//                 child: _statCard('17+', 'Months\nExperience', Icons.work_outline, dark)),
//             const SizedBox(width: 16),
//             Expanded(
//                 child: _statCard('4', 'Projects\nDelivered', Icons.rocket_launch_outlined, dark)),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//                 child: _statCard('8+', 'Skills\nMastered', Icons.star_outline, dark)),
//             const SizedBox(width: 16),
//             Expanded(
//                 child: _statCard('100%', 'Client\nSatisfaction', Icons.thumb_up_outlined, dark)),
//           ],
//         ),
//         const SizedBox(height: 16),
//         // Contact info card
//         GlassCard(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Get In Touch', style: AppTextStyles.cardTitle(dark)),
//               const SizedBox(height: 14),
//               _infoRow(Icons.email_outlined, PortfolioData.email, dark),
//               const SizedBox(height: 10),
//               _infoRow(Icons.phone_outlined, PortfolioData.phone, dark),
//               const SizedBox(height: 10),
//               _infoRow(Icons.location_on_outlined, PortfolioData.location, dark),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _statCard(String value, String label, IconData icon, bool dark) {
//     return HoverCard(
//       padding: const EdgeInsets.all(18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: AppColors.teal, size: 22),
//           const SizedBox(height: 10),
//           ShaderMask(
//             blendMode: BlendMode.srcIn,
//             shaderCallback: (b) => AppColors.primary
//                 .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
//             child: Text(value,
//                 style: const TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w800,
//                     letterSpacing: -1)),
//           ),
//           const SizedBox(height: 4),
//           Text(label, style: AppTextStyles.label(dark)),
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(IconData icon, String text, bool dark) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: AppColors.teal),
//         const SizedBox(width: 10),
//         Expanded(
//             child: Text(text,
//                 style: AppTextStyles.body(dark).copyWith(fontSize: 13),
//                 overflow: TextOverflow.ellipsis)),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../data.dart';
import '../widgets/animated_reveal.dart';
import '../widgets/glass_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  // Helper method to clean phone number
  String _cleanPhoneNumber(String phone) {
    // Remove spaces and special characters but keep plus sign for international dialing
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    // If the number starts with +, keep it as is
    if (cleaned.startsWith('+')) {
      return cleaned;
    }
    
    // Remove any leading zeros
    cleaned = cleaned.replaceFirst(RegExp(r'^0+'), '');
    
    // If it's a 10-digit number without country code, add +91
    if (cleaned.length == 10) {
      cleaned = '+91$cleaned';
    }
    
    return cleaned;
  }

  // Helper method to trigger the phone dialer
  Future<void> _makeCall(String phoneNumber) async {
    final cleanedNumber = _cleanPhoneNumber(phoneNumber);
    print('Attempting to call: $cleanedNumber');
    
    if (cleanedNumber.isEmpty) return;
    
    final Uri launchUri = Uri(scheme: 'tel', path: cleanedNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Cannot launch URL: $launchUri');
    }
  }

  // Helper method to send email
  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Cannot launch email: $emailUri');
    }
  }

  // Helper method to open maps
  Future<void> _openMaps(String location) async {
    final Uri mapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}');
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    } else {
      print('Cannot launch maps: $mapsUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 750;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: isMobile ? 50 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedReveal(
            child: SectionHeader(
              label: 'Who I Am',
              title: 'About Me',
              dark: dark,
            ),
          ),
          const SizedBox(height: 44),
          AnimatedReveal(
            delay: const Duration(milliseconds: 150),
            child: isMobile
                ? _buildMobileContent(dark)
                : _buildDesktopContent(dark),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(bool dark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildBio(dark)),
        const SizedBox(width: 40),
        Expanded(flex: 4, child: _buildStats(dark)),
      ],
    );
  }

  Widget _buildMobileContent(bool dark) {
    return Column(
      children: [
        _buildBio(dark),
        const SizedBox(height: 32),
        _buildStats(dark),
      ],
    );
  }

  Widget _buildBio(bool dark) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Story', style: AppTextStyles.cardTitle(dark)),
          const SizedBox(height: 16),
          Text(PortfolioData.summary, style: AppTextStyles.body(dark)),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          ...PortfolioData.education.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.school_outlined,
                      color: AppColors.teal,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e['degree']!,
                          style: AppTextStyles.cardTitle(
                            dark,
                          ).copyWith(fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${e['institute']}  •  ${e['year']}  •  ${e['grade']}',
                          style: AppTextStyles.label(dark),
                        ),
                      ],
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

  Widget _buildStats(bool dark) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _statCard(
                '17+',
                'Months\nExperience',
                Icons.work_outline,
                dark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _statCard(
                '4',
                'Projects\nDelivered',
                Icons.rocket_launch_outlined,
                dark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _statCard(
                '8+',
                'Skills\nMastered',
                Icons.star_outline,
                dark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _statCard(
                '100%',
                'Client\nSatisfaction',
                Icons.thumb_up_outlined,
                dark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get In Touch', style: AppTextStyles.cardTitle(dark)),
              const SizedBox(height: 14),
              _infoRow(
                Icons.email_outlined,
                PortfolioData.email,
                dark,
                onTap: () => _sendEmail(PortfolioData.email),
              ),
              const SizedBox(height: 10),
              _infoRow(
                Icons.phone_outlined,
                PortfolioData.phone,
                dark,
                onTap: () => _makeCall(PortfolioData.phone),
              ),
              const SizedBox(height: 10),
              _infoRow(
                Icons.location_on_outlined,
                PortfolioData.location,
                dark,
                onTap: () => _openMaps(PortfolioData.location),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(String value, String label, IconData icon, bool dark) {
    return HoverCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.teal, size: 22),
          const SizedBox(height: 10),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (b) => AppColors.primary.createShader(
              Rect.fromLTWH(0, 0, b.width, b.height),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.label(dark)),
        ],
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String text,
    bool dark, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.teal),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body(dark).copyWith(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}