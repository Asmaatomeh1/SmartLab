import 'package:appwithfirebase/features/authentication/auth.dart';
import 'package:appwithfirebase/model/patient_model.dart';
import 'package:appwithfirebase/features/proflie/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ── Sample patient data ──────────────────────────────────────────────────
  final Map<String, String> _personalInfo = {
    'Full Name': AppAuth.currentUser?.fullNameText ?? '',
    'Date of Birth':
        AppAuth.currentUser?.birthDate.toLocal().toString().split(' ')[0] ?? '',
    'Phone': AppAuth.currentUser?.phone ?? '',
    'Email': AppAuth.currentUser?.email ?? '',
    // 'Location':
    'Patient ID': FirebaseAuth.instance.currentUser?.uid ?? '',
  };

  // final Map<String, dynamic> _medicalInfo = {
  //   'Blood Type': Profile.currentProfileModel?.bloodType ?? '',
  //   'Allergies': Profile.currentProfileModel?.allergies ?? '',
  //   'Medications': Profile.currentProfileModel?.medications ?? '',
  //   'Conditions': Profile.currentProfileModel?.conditions ?? '',
  // };
  final Map<String, dynamic> _medicalInfo = {
    'Blood Type': Profile.currentProfileModel?.bloodType.label ?? 'N/A',
    'Allergies': Profile.currentProfileModel?.allergies ?? [],
    'Medications': Profile.currentProfileModel?.medications ?? [],
    'Conditions': Profile.currentProfileModel?.conditions ?? [],
  };

  final List<Map<String, dynamic>> _healthIndicators = [
    {
      'label': 'Health Score',
      'value': '0.85',
      'status': 'perfect',
      'progress': 0.72,
      'statusColor': Color(0xFFB45309),
      'barColor': Color(0xFFEF9F27),
    },
    {
      'label': 'Blood Pressure',
      'value': '128 / 82',
      'status': 'OK',
      'progress': 0.55,
      'statusColor': Color(0xFF3B6D11),
      'barColor': Color(0xFF1A73C1),
    },
    {
      'label': 'HbA1c',
      'value': '7.1 %',
      'status': 'Watch',
      'progress': 0.65,
      'statusColor': Color(0xFFB45309),
      'barColor': Color(0xFFEF9F27),
    },
    {
      'label': 'Cholesterol',
      'value': '185 mg/dL',
      'status': 'Good',
      'progress': 0.40,
      'statusColor': Color(0xFF3B6D11),
      'barColor': Color(0xFF1A73C1),
    },
  ];

  // ── Theme colours ────────────────────────────────────────────────────────
  static const Color _primary = Color(0xFF1A73C1);
  static const Color _teal = Color(0xFF0D9488);
  static const Color _surface = Color(0xFFF8F9FB);
  static const Color _cardBg = Colors.white;
  static const Color _border = Color(0xFFE5E7EB);
  static const Color _textMain = Color(0xFF111827);
  static const Color _textSub = Color(0xFF6B7280);

  // ── Stat data ────────────────────────────────────────────────────────────
  final List<Map<String, String>> _stats = [
    {'value': '12', 'label': 'Total Visits'},
    {'value': '3', 'label': 'Upcoming'},
    {'value': '98%', 'label': 'Attendance'},
  ];

  @override
  initState() {
    super.initState();
    fun();
  }

  fun() async {
    await Profile().getCurrentProfile();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // _buildStatsRow(),
                  const SizedBox(height: 12),
                  _buildPersonalInfoCard(),
                  const SizedBox(height: 12),
                  _buildMedicalProfileCard(),
                  const SizedBox(height: 12),
                  _buildHealthIndicatorsCard(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Sliver App Bar with cover + avatar ─────────────────────────────────
  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: _primary,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () => Navigator.maybePop(context),
      ),
      actions: [
        TextButton.icon(
          onPressed: _onEditProfile,
          icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 16),
          label: const Text(
            'Edit',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Gradient cover
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F4C8A),
                    Color(0xFF1A73C1),
                    Color(0xFF0D9488),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Decorative circles
            Positioned(
              top: -30,
              right: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: -10,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            // Live badge
            const Positioned(top: 56, right: 16, child: _LiveBadge()),
            // Avatar + name pinned at bottom of cover
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Avatar
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1A73C1), Color(0xFF0D9488)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        AppAuth.currentUser?.fullNameText
                                .substring(0, 1)
                                .toUpperCase() ??
                            '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppAuth.currentUser?.fullNameText ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // Text(
                          //   'SL-2024-00847',
                          //   style: TextStyle(
                          //     color: Colors.white.withOpacity(0.75),
                          //     fontSize: 12,
                          //   ),
                          // ),
                        ],
                      ),
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

  // ── Stats row ────────────────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: _stats.map((s) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: _stats.indexOf(s) == 0 ? 0 : 6,
              right: _stats.indexOf(s) == _stats.length - 1 ? 0 : 6,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _border, width: 0.8),
            ),
            child: Column(
              children: [
                Text(
                  s['value']!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: _textMain,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  s['label']!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: _textSub,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Section card wrapper ─────────────────────────────────────────────────
  Widget _sectionCard({
    required String title,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _textSub,
                    letterSpacing: 0.8,
                  ),
                ),
                if (trailing != null) ...[const Spacer(), trailing],
              ],
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  // ── Personal info ────────────────────────────────────────────────────────
  Widget _buildPersonalInfoCard() {
    final icons = [
      Icons.person_outline,
      Icons.cake_outlined,
      Icons.phone_outlined,
      Icons.email_outlined,
      Icons.location_on_outlined,
      Icons.badge_outlined,
    ];
    final iconColors = [
      const Color(0xFF185FA5),
      const Color(0xFF0F6E56),
      const Color(0xFF854F0B),
      const Color(0xFF534AB7),
      const Color(0xFF185FA5),
      const Color(0xFF0F6E56),
    ];
    final bgColors = [
      const Color(0xFFE6F1FB),
      const Color(0xFFE1F5EE),
      const Color(0xFFFAEEDA),
      const Color(0xFFEEEDFE),
      const Color(0xFFE6F1FB),
      const Color(0xFFE1F5EE),
    ];

    final entries = _personalInfo.entries.toList();

    return _sectionCard(
      title: 'Personal information',
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const Divider(height: 1, color: _border),
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: bgColors[i],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icons[i], color: iconColors[i], size: 17),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entries[i].key,
                      style: const TextStyle(fontSize: 11, color: _textSub),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      entries[i].value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _textMain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Medical profile ──────────────────────────────────────────────────────
  Widget _buildMedicalProfileCard() {
    return _sectionCard(
      title: 'Medical profile',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
        child: Column(
          children: [
            _medicalRow(
              icon: Icons.bloodtype_outlined,
              iconColor: const Color(0xFF185FA5),
              bgColor: const Color(0xFFE6F1FB),
              label: 'Blood type',
              child: Text(
                _medicalInfo['Blood Type'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _textMain,
                ),
              ),
            ),
            const Divider(height: 16, color: _border),
            _medicalRow(
              icon: Icons.warning_amber_outlined,
              iconColor: const Color(0xFF854F0B),
              bgColor: const Color(0xFFFAEEDA),
              label: 'Allergies',
              child: _tagWrap(
                _medicalInfo['Allergies'],
                const Color(0xFFFAEEDA),
                const Color(0xFF854F0B),
              ),
            ),
            const Divider(height: 16, color: _border),
            _medicalRow(
              icon: Icons.medication_outlined,
              iconColor: const Color(0xFF534AB7),
              bgColor: const Color(0xFFEEEDFE),
              label: 'Medications',
              child: _tagWrap(
                _medicalInfo['Medications'],
                const Color(0xFFEEEDFE),
                const Color(0xFF534AB7),
              ),
            ),
            const Divider(height: 16, color: _border),
            _medicalRow(
              icon: Icons.local_hospital_outlined,
              iconColor: const Color(0xFF0F6E56),
              bgColor: const Color(0xFFE1F5EE),
              label: 'Conditions',
              child: _tagWrap(
                _medicalInfo['Conditions'],
                const Color(0xFFE1F5EE),
                const Color(0xFF0F6E56),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _medicalRow({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required Widget child,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 17),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: _textSub),
              ),
              const SizedBox(height: 4),
              child,
            ],
          ),
        ),
      ],
    );
  }

  Widget _tagWrap(List<dynamic> tags, Color bg, Color fg) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: tags
          .map(
            (t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                t,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: fg,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // ── Health indicators ────────────────────────────────────────────────────
  Widget _buildHealthIndicatorsCard() {
    return _sectionCard(
      title: 'Health indicators',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
        child: Column(
          children: List.generate(_healthIndicators.length, (i) {
            final h = _healthIndicators[i];
            return Column(
              children: [
                if (i > 0) const Divider(height: 16, color: _border),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                h['label'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: _textMain,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    h['value'],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: _textMain,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (h['statusColor'] as Color)
                                          .withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      h['status'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: h['statusColor'],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: LinearProgressIndicator(
                              value: h['progress'],
                              minHeight: 5,
                              backgroundColor: const Color(0xFFE5E7EB),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                h['barColor'],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // ── Actions ──────────────────────────────────────────────────────────────
  void _onEditProfile() {
    // Navigate to edit profile page or show bottom sheet
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Profile editing coming soon.',
              style: TextStyle(color: _textSub),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Live badge widget ────────────────────────────────────────────────────────
class _LiveBadge extends StatefulWidget {
  const _LiveBadge();
  @override
  State<_LiveBadge> createState() => _LiveBadgeState();
}

class _LiveBadgeState extends State<_LiveBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 1, end: 0.3).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: _anim,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Color(0xFF4ADE80),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Smart Lab',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:appwithfirebase/edit_patient_cubit.dart';
// import 'package:appwithfirebase/edit_patient_state.dart';
// import 'package:appwithfirebase/model/patient_model.dart';
// import 'package:appwithfirebase/patient_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // ─────────────────────────────────────────────────────────────────────────────
// // Entry point — provides the cubit
// // ─────────────────────────────────────────────────────────────────────────────

// class EditProfileProvider extends StatelessWidget {
//   final String patientId;
//   const EditProfileProvider({super.key, required this.patientId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => EditProfileCubit()..loadPatient(patientId),
//       child: const EditProfilePage(),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Page
// // ─────────────────────────────────────────────────────────────────────────────

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key});

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final _formKey = GlobalKey<FormState>();

//   // Text controllers — filled once data loads
//   final _firstNameCtrl = TextEditingController();
//   final _lastNameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _phoneCtrl = TextEditingController();
//   final _locationCtrl = TextEditingController();

//   // Chip input controllers
//   final _allergyCtrl = TextEditingController();
//   final _medCtrl = TextEditingController();
//   final _condCtrl = TextEditingController();

//   bool _controllersPopulated = false;

//   // ── Theme ─────────────────────────────────────────────────────────────────
//   static const Color _primary = Color(0xFF1A73C1);
//   static const Color _surface = Color(0xFFF8F9FB);
//   static const Color _cardBg = Colors.white;
//   static const Color _border = Color(0xFFE5E7EB);
//   static const Color _textMain = Color(0xFF111827);
//   static const Color _textSub = Color(0xFF6B7280);

//   @override
//   void dispose() {
//     _firstNameCtrl.dispose();
//     _lastNameCtrl.dispose();
//     _emailCtrl.dispose();
//     _phoneCtrl.dispose();
//     _locationCtrl.dispose();
//     _allergyCtrl.dispose();
//     _medCtrl.dispose();
//     _condCtrl.dispose();
//     super.dispose();
//   }

//   void _populateControllers(PatientModel patient) {
//     if (_controllersPopulated) return;
//     _firstNameCtrl.text = patient.firstName;
//     _lastNameCtrl.text = patient.lastName;
//     _emailCtrl.text = patient.email;
//     _phoneCtrl.text = patient.phone;
//     _locationCtrl.text = patient.location;
//     _controllersPopulated = true;
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // Build
//   // ─────────────────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<EditProfileCubit, EditProfileState>(
//       listener: (context, state) {
//         if (state is EditProfileSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: const Text('Profile updated successfully'),
//               backgroundColor: const Color(0xFF0F6E56),
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           );
//           Navigator.pop(context, state.updatedPatient);
//         }

//         if (state is EditProfileError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: const Color(0xFFDC2626),
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           );
//         }

//         if (state is EditProfileLoaded) {
//           _populateControllers(state.patient);
//         }
//       },
//       builder: (context, state) {
//         if (state is EditProfileLoading || state is EditProfileInitial) {
//           return const Scaffold(
//             backgroundColor: _surface,
//             body: Center(child: CircularProgressIndicator(color: _primary)),
//           );
//         }

//         final patient = _getPatient(state);
//         if (patient == null) {
//           return Scaffold(
//             backgroundColor: _surface,
//             body: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     size: 48,
//                     color: Color(0xFFDC2626),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     state is EditProfileError
//                         ? state.message
//                         : 'Something went wrong',
//                     style: const TextStyle(color: _textSub),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: _primary),
//                     onPressed: () => context
//                         .read<EditProfileCubit>()
//                         .loadPatient(patient?.patientId ?? ''),
//                     child: const Text(
//                       'Retry',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         final isSaving = state is EditProfileSaving;

//         return Scaffold(
//           backgroundColor: _surface,
//           appBar: _buildAppBar(context, isSaving),
//           body: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//               child: Column(
//                 children: [
//                   _buildAvatarSection(context, patient),
//                   const SizedBox(height: 20),
//                   _buildPersonalSection(context, patient),
//                   const SizedBox(height: 12),
//                   _buildMedicalSection(context, patient),
//                   const SizedBox(height: 28),
//                   _buildSaveButton(context, isSaving),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   PatientModel? _getPatient(EditProfileState state) {
//     if (state is EditProfileLoaded) return state.patient;
//     if (state is EditProfileSaving) return state.patient;
//     if (state is EditProfileError) return state.patient;
//     return null;
//   }

//   // ── AppBar ────────────────────────────────────────────────────────────────

//   AppBar _buildAppBar(BuildContext context, bool isSaving) {
//     return AppBar(
//       backgroundColor: _primary,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back_ios_new,
//           color: Colors.white,
//           size: 18,
//         ),
//         onPressed: isSaving ? null : () => Navigator.maybePop(context),
//       ),
//       title: const Text(
//         'Edit Profile',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 17,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: isSaving ? null : () => _onSave(context),
//           child: isSaving
//               ? const SizedBox(
//                   width: 18,
//                   height: 18,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                     strokeWidth: 2,
//                   ),
//                 )
//               : const Text(
//                   'Save',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//         ),
//         const SizedBox(width: 8),
//       ],
//     );
//   }

//   // ── Avatar ────────────────────────────────────────────────────────────────

//   Widget _buildAvatarSection(BuildContext context, PatientModel patient) {
//     final initials =
//         '${patient.firstName.isNotEmpty ? patient.firstName[0] : ''}${patient.lastName.isNotEmpty ? patient.lastName[0] : ''}'
//             .toUpperCase();

//     return Center(
//       child: Stack(
//         children: [
//           Container(
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF1A73C1), Color(0xFF0D9488)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               border: Border.all(color: Colors.white, width: 3),
//               boxShadow: [
//                 BoxShadow(
//                   color: _primary.withOpacity(0.25),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: patient.profileImage.isNotEmpty
//                   ? ClipOval(
//                       child: Image.network(
//                         patient.profileImage,
//                         fit: BoxFit.cover,
//                         width: 90,
//                         height: 90,
//                       ),
//                     )
//                   : Text(
//                       initials,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 26,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: () {
//                 // TODO: integrate image_picker and upload to Firebase Storage
//                 // then call: context.read<EditProfileCubit>().updateProfileImage(url);
//               },
//               child: Container(
//                 width: 28,
//                 height: 28,
//                 decoration: BoxDecoration(
//                   color: _primary,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2),
//                 ),
//                 child: const Icon(
//                   Icons.camera_alt,
//                   color: Colors.white,
//                   size: 13,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Personal section ──────────────────────────────────────────────────────

//   Widget _buildPersonalSection(BuildContext context, PatientModel patient) {
//     final cubit = context.read<EditProfileCubit>();

//     return _sectionCard(
//       title: 'Personal information',
//       child: Column(
//         children: [
//           _field(
//             controller: _firstNameCtrl,
//             label: 'First name',
//             icon: Icons.person_outline,
//             onChanged: cubit.updateFirstName,
//             validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
//           ),
//           _divider(),
//           _field(
//             controller: _lastNameCtrl,
//             label: 'Last name',
//             icon: Icons.person_outline,
//             onChanged: cubit.updateLastName,
//             validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
//           ),
//           _divider(),
//           _field(
//             controller: _emailCtrl,
//             label: 'Email',
//             icon: Icons.email_outlined,
//             keyboardType: TextInputType.emailAddress,
//             onChanged: cubit.updateEmail,
//             validator: (v) {
//               if (v == null || v.trim().isEmpty) return 'Required';
//               if (!v.contains('@')) return 'Enter a valid email';
//               return null;
//             },
//           ),
//           _divider(),
//           _field(
//             controller: _phoneCtrl,
//             label: 'Phone',
//             icon: Icons.phone_outlined,
//             keyboardType: TextInputType.phone,
//             onChanged: cubit.updatePhone,
//             validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
//           ),
//           _divider(),
//           // Date of birth
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Row(
//               children: [
//                 _iconBox(
//                   Icons.cake_outlined,
//                   const Color(0xFFE1F5EE),
//                   const Color(0xFF0F6E56),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => _pickDate(context, patient),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Date of birth',
//                           style: TextStyle(fontSize: 11, color: _textSub),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           '${patient.birthDate.year}-'
//                           '${patient.birthDate.month.toString().padLeft(2, '0')}-'
//                           '${patient.birthDate.day.toString().padLeft(2, '0')}',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: _textMain,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: _textSub,
//                 ),
//               ],
//             ),
//           ),
//           _divider(),
//           _field(
//             controller: _locationCtrl,
//             label: 'Location',
//             icon: Icons.location_on_outlined,
//             onChanged: cubit.updateLocation,
//             validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Medical section ───────────────────────────────────────────────────────

//   Widget _buildMedicalSection(BuildContext context, PatientModel patient) {
//     final cubit = context.read<EditProfileCubit>();

//     return _sectionCard(
//       title: 'Medical profile',
//       child: Column(
//         children: [
//           // Blood type
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Row(
//               children: [
//                 _iconBox(
//                   Icons.bloodtype_outlined,
//                   const Color(0xFFE6F1FB),
//                   const Color(0xFF185FA5),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Blood type',
//                         style: TextStyle(fontSize: 11, color: _textSub),
//                       ),
//                       const SizedBox(height: 4),
//                       DropdownButtonHideUnderline(
//                         child: DropdownButton<BloodType>(
//                           value: patient.bloodType,
//                           isDense: true,
//                           icon: const Icon(
//                             Icons.keyboard_arrow_down,
//                             size: 18,
//                             color: _textSub,
//                           ),
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: _textMain,
//                           ),
//                           items: BloodType.values
//                               .map(
//                                 (b) => DropdownMenuItem(
//                                   value: b,
//                                   child: Text(b.label),
//                                 ),
//                               )
//                               .toList(),
//                           onChanged: (v) =>
//                               v != null ? cubit.updateBloodType(v) : null,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           _divider(),
//           _chipField(
//             icon: Icons.warning_amber_outlined,
//             iconBg: const Color(0xFFFAEEDA),
//             iconColor: const Color(0xFF854F0B),
//             tagBg: const Color(0xFFFAEEDA),
//             tagColor: const Color(0xFF854F0B),
//             label: 'Allergies',
//             items: patient.allergies,
//             controller: _allergyCtrl,
//             onAdd: cubit.addAllergy,
//             onRemove: cubit.removeAllergy,
//           ),
//           _divider(),
//           _chipField(
//             icon: Icons.medication_outlined,
//             iconBg: const Color(0xFFEEEDFE),
//             iconColor: const Color(0xFF534AB7),
//             tagBg: const Color(0xFFEEEDFE),
//             tagColor: const Color(0xFF534AB7),
//             label: 'Medications',
//             items: patient.medications,
//             controller: _medCtrl,
//             onAdd: cubit.addMedication,
//             onRemove: cubit.removeMedication,
//           ),
//           _divider(),
//           _chipField(
//             icon: Icons.local_hospital_outlined,
//             iconBg: const Color(0xFFE1F5EE),
//             iconColor: const Color(0xFF0F6E56),
//             tagBg: const Color(0xFFE1F5EE),
//             tagColor: const Color(0xFF0F6E56),
//             label: 'Conditions',
//             items: patient.conditions,
//             controller: _condCtrl,
//             onAdd: cubit.addCondition,
//             onRemove: cubit.removeCondition,
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Save button ───────────────────────────────────────────────────────────

//   Widget _buildSaveButton(BuildContext context, bool isSaving) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: isSaving ? null : () => _onSave(context),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _primary,
//           disabledBackgroundColor: _primary.withOpacity(0.6),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 0,
//         ),
//         child: isSaving
//             ? const SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//             : const Text(
//                 'Save changes',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // Helpers
//   // ─────────────────────────────────────────────────────────────────────────

//   void _onSave(BuildContext context) {
//     if (!_formKey.currentState!.validate()) return;
//     context.read<EditProfileCubit>().saveProfile();
//   }

//   Future<void> _pickDate(BuildContext context, PatientModel patient) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: patient.birthDate,
//       firstDate: DateTime(1920),
//       lastDate: DateTime.now(),
//       builder: (ctx, child) => Theme(
//         data: Theme.of(
//           ctx,
//         ).copyWith(colorScheme: const ColorScheme.light(primary: _primary)),
//         child: child!,
//       ),
//     );
//     if (picked != null && context.mounted) {
//       context.read<EditProfileCubit>().updateBirthDate(picked);
//     }
//   }

//   Widget _sectionCard({required String title, required Widget child}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: _cardBg,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: _border, width: 0.8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
//             child: Text(
//               title.toUpperCase(),
//               style: const TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w600,
//                 color: _textSub,
//                 letterSpacing: 0.8,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
//             child: child,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _field({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     void Function(String)? onChanged,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           _iconBox(icon, const Color(0xFFF3F4F6), _textSub),
//           const SizedBox(width: 12),
//           Expanded(
//             child: TextFormField(
//               controller: controller,
//               keyboardType: keyboardType,
//               onChanged: onChanged,
//               validator: validator,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: _textMain,
//               ),
//               decoration: InputDecoration(
//                 labelText: label,
//                 labelStyle: const TextStyle(fontSize: 12, color: _textSub),
//                 isDense: true,
//                 contentPadding: EdgeInsets.zero,
//                 border: InputBorder.none,
//                 errorStyle: const TextStyle(
//                   fontSize: 11,
//                   color: Color(0xFFDC2626),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _chipField({
//     required IconData icon,
//     required Color iconBg,
//     required Color iconColor,
//     required Color tagBg,
//     required Color tagColor,
//     required String label,
//     required List<String> items,
//     required TextEditingController controller,
//     required void Function(String) onAdd,
//     required void Function(String) onRemove,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _iconBox(icon, iconBg, iconColor),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(fontSize: 11, color: _textSub),
//                 ),
//                 const SizedBox(height: 6),
//                 Wrap(
//                   spacing: 6,
//                   runSpacing: 6,
//                   children: [
//                     ...items.map(
//                       (item) => GestureDetector(
//                         onTap: () => onRemove(item),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 5,
//                           ),
//                           decoration: BoxDecoration(
//                             color: tagBg,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 item,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: tagColor,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               Icon(Icons.close, size: 12, color: tagColor),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => _showAddDialog(label, controller, onAdd),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 5,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF3F4F6),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: _border),
//                         ),
//                         child: const Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(Icons.add, size: 13, color: _textSub),
//                             SizedBox(width: 3),
//                             Text(
//                               'Add',
//                               style: TextStyle(fontSize: 12, color: _textSub),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddDialog(
//     String label,
//     TextEditingController ctrl,
//     void Function(String) onAdd,
//   ) {
//     ctrl.clear();
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         title: Text(
//           'Add $label',
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         content: TextField(
//           controller: ctrl,
//           autofocus: true,
//           decoration: InputDecoration(
//             hintText: 'Enter value...',
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: _primary),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel', style: TextStyle(color: _textSub)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: _primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               elevation: 0,
//             ),
//             onPressed: () {
//               final val = ctrl.text.trim();
//               if (val.isNotEmpty) onAdd(val);
//               Navigator.pop(context);
//             },
//             child: const Text('Add', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _iconBox(IconData icon, Color bg, Color color) {
//     return Container(
//       width: 34,
//       height: 34,
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Icon(icon, color: color, size: 17),
//     );
//   }

//   Widget _divider() => const Divider(height: 1, color: _border);
// }
