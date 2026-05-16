// // import 'package:appwithfirebase/core/theme/appcolor.dart';
// // import 'package:appwithfirebase/core/theme/appfont.dart';
// // import 'package:appwithfirebase/my_text_form_field.dart';
// // import 'package:appwithfirebase/test/test_cubit.dart';
// // import 'package:appwithfirebase/test/test_state.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class TestSelectionStep extends StatelessWidget {
// //   const TestSelectionStep({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: BlocBuilder<TestCubit, TestState>(
// //         builder: (context, state) {
// //           if (state is TestLoading) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (state is TestLoaded) {
// //             var cubit = context.read<TestCubit>();

// //             return
// //             //backgroundColor: AppColors.white,
// //             Column(
// //               children: [
// //                 /// 🔎 Search + Cart
// //                 Padding(
// //                   padding: const EdgeInsets.all(12),

// //                   child: Row(
// //                     children: [
// //                       /// Search
// //                       Expanded(
// //                         child: MyTextFormField(
// //                           onChanged: cubit.searchTests,

// //                           labelText: "Search tests...",
// //                           // controller: TextEditingController(),
// //                         ),
// //                       ),

// //                       const SizedBox(width: 10),

// //                       /// 🛒 Cart Count
// //                       Stack(
// //                         children: [
// //                           const Icon(
// //                             Icons.shopping_cart,
// //                             size: 30,
// //                             color: AppColors.blue,
// //                           ),

// //                           if (state.selectedTests.isNotEmpty)
// //                             Positioned(
// //                               right: 0,
// //                               top: 0,

// //                               child: Container(
// //                                 padding: const EdgeInsets.all(4),

// //                                 decoration: BoxDecoration(
// //                                   color: Colors.red,
// //                                   shape: BoxShape.circle,
// //                                 ),

// //                                 child: Text(
// //                                   state.selectedTests.length.toString(),

// //                                   style: const TextStyle(
// //                                     color: Colors.white,
// //                                     fontSize: 10,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 /// 📋 List
// //                 Stack(
// //                   // clipBehavior: Clip.antiAlias,
// //                   //fit: StackFit.passthrough,
// //                   children: [
// //                     SizedBox(
// //                       height: 440.h,
// //                       child: Column(
// //                         children: [
// //                           // SizedBox(height: 100.h),
// //                           SizedBox(
// //                             height: 390.h,
// //                             child: ListView.builder(
// //                               itemCount: state.filteredTests.length,

// //                               itemBuilder: (context, index) {
// //                                 var test = state.filteredTests[index];

// //                                 bool isSelected = state.selectedTests.contains(
// //                                   test,
// //                                 );

// //                                 return ChoiceChip(
// //                                   // padding: const EdgeInsets.symmetric(
// //                                   //   horizontal: 12,
// //                                   //   vertical: 4,
// //                                   // ),
// //                                   label: SizedBox(
// //                                     height: 60,
// //                                     child: ListTile(
// //                                       // contentPadding: const EdgeInsets.symmetric(
// //                                       //   horizontal: 12,
// //                                       //   vertical: 1,
// //                                       // ),
// //                                       selectedTileColor: AppColors.blue,
// //                                       //iconColor: AppColors.blue,
// //                                       // selected: true,
// //                                       // selectedColor: AppColors.blue,
// //                                       //selectedTileColor: AppColors.blue,
// //                                       title: Text(
// //                                         state.filteredTests[index].name,
// //                                         style: AppFonts.subtitleBlackMedium
// //                                             .copyWith(fontSize: 25),
// //                                       ),
// //                                       // subtitle: Text(
// //                                       //   state.filteredTests[index].description,
// //                                       // ),
// //                                       trailing: Text(
// //                                         '\$${state.filteredTests[index].price}',
// //                                         style: AppFonts.subtitleGreyMedium
// //                                             .copyWith(
// //                                               fontSize: 30,
// //                                               color: AppColors.blue,
// //                                             ),
// //                                       ),
// //                                     ),
// //                                   ),

// //                                   selected: isSelected,
// //                                   onSelected: (selected) {
// //                                     // Handle tap
// //                                     cubit.toggleSelection(test);

// //                                   },

// //                                   backgroundColor: Colors.white,
// //                                   color: WidgetStateProperty.resolveWith<Color>((
// //                                     states,
// //                                   ) {
// //                                     if (states.contains(WidgetState.selected)) {
// //                                       return AppColors.blue.withOpacity(0.2);
// //                                     }
// //                                     if (states.contains(WidgetState.hovered) ||
// //                                         states.contains(WidgetState.focused) ||
// //                                         states.contains(WidgetState.pressed)) {
// //                                       return AppColors.blue.withOpacity(0.1);
// //                                     }
// //                                     return Colors
// //                                         .white; // Default color when no state is active
// //                                   }),
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                           SizedBox(height: 50.h),
// //                         ],
// //                       ),
// //                     ),
// //                     Positioned(
// //                       top: 390.h,

// //                       left: 130.w,

// //                       child: Center(
// //                         child: Container(

// //                           height: 50,
// //                           padding: EdgeInsets.symmetric(

// //                           ),

// //                           child: Center(
// //                             child: Text(
// //                               "Total: ${cubit.totalPrice} ₪",

// //                               style: AppFonts.titleBlue.copyWith(
// //                                 fontSize: 30,

// //                                 /// color: AppColors.blue,
// //                               ),
// //                             ),
// //                           ),
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(8),
// //                             color: AppColors.blue.withOpacity(0.1),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),

// //               ],
// //             );
// //           }

// //           if (state is TestError) {
// //             return Center(child: Text(state.message));
// //           }

// //           return const SizedBox();
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:appwithfirebase/core/theme/appcolor.dart';
// import 'package:appwithfirebase/core/theme/appfont.dart';
// import 'package:appwithfirebase/model/test_model.dart';
// import 'package:appwithfirebase/my_text_form_field.dart';
// import 'package:appwithfirebase/test/test_cubit.dart';
// import 'package:appwithfirebase/test_state.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TestSelectionStep extends StatelessWidget {
//   const TestSelectionStep({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<TestCubit, TestState>(
//         builder: (context, state) {
//           return switch (state) {
//             TestLoading() => const Center(child: CircularProgressIndicator()),
//             TestLoaded() => _buildLoadedState(context, state),
//             TestError() => Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error, size: 64, color: Colors.red),
//                   SizedBox(height: 16),
//                   Text(state.message, textAlign: TextAlign.center),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => context.read<TestCubit>().loadTests(),
//                     child: Text('Retry'),
//                   ),
//                 ],
//               ),
//             ),
//             _ => const SizedBox(),
//           };
//         },
//       ),
//     );
//   }

//   Widget _buildLoadedState(BuildContext context, TestLoaded state) {
//     final cubit = context.read<TestCubit>();

//     return Column(
//       children: [
//         _buildSearchHeader(context, cubit, state),
//         Expanded(child: _buildTestList(context, cubit, state)),
//         _buildTotalBar(context, cubit),
//       ],
//     );
//   }

//   Widget _buildSearchHeader(
//     BuildContext context,
//     TestCubit cubit,
//     TestLoaded state,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           Expanded(
//             child: MyTextFormField(
//               onChanged: cubit.searchTests,
//               labelText: "Search tests...",
//             ),
//           ),
//           const SizedBox(width: 16),
//           _buildCartIcon(state),
//         ],
//       ),
//     );
//   }

//   Widget _buildCartIcon(TestLoaded state) {
//     return Stack(
//       children: [
//         const Icon(Icons.shopping_cart, size: 30, color: AppColors.blue),
//         if (state.selectedTests.isNotEmpty)
//           Positioned(
//             right: 0,
//             top: 0,
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//               constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
//               child: Text(
//                 state.selectedTests.length.toString(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildTestList(
//     BuildContext context,
//     TestCubit cubit,
//     TestLoaded state,
//   ) {
//     if (state.filteredTests.isEmpty) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.search_off, size: 64, color: Colors.grey),
//             SizedBox(height: 16),
//             Text(
//               'No tests found',
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: state.filteredTests.length,
//       itemBuilder: (context, index) {
//         final test = state.filteredTests[index];
//         return _buildTestItem(cubit, test);
//       },
//     );
//   }

//   Widget _buildTestItem(TestCubit cubit, TestModel test) {
//     final isSelected = cubit.isSelected(test);

//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       child: ChoiceChip(
//         label: Container(
//           height: 60,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   test.name,
//                   style: AppFonts.subtitleBlackMedium.copyWith(
//                     fontSize: 16,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//                   ),
//                 ),
//               ),
//               Text(
//                 '${test.price} ₪',
//                 style: AppFonts.subtitleGreyMedium.copyWith(
//                   fontSize: 16,
//                   color: AppColors.blue,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         selected: isSelected,
//         onSelected: (_) => cubit.toggleSelection(test),
//         backgroundColor: Colors.white,
//         selectedColor: AppColors.blue.withOpacity(0.2),
//         side: BorderSide(
//           color: isSelected ? AppColors.blue : Colors.grey.shade300,
//           width: isSelected ? 2 : 1,
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }

//   Widget _buildTotalBar(BuildContext context, TestCubit cubit) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.blue.withOpacity(0.1),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       child: Text(
//         "Total: ${cubit.totalPrice} ₪",
//         style: AppFonts.titleBlue.copyWith(
//           fontSize: 20,
//           fontWeight: FontWeight.w700,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

// test/test_selection_step.dart
import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:appwithfirebase/core/theme/appfont.dart';
import 'package:appwithfirebase/model/test_model.dart';
import 'package:appwithfirebase/shared_widget/my_text_form_field.dart';
import 'package:appwithfirebase/test/test_cubit.dart';
import 'package:appwithfirebase/test_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestSelectionStep extends StatelessWidget {
  const TestSelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestCubit, TestState>(
      builder: (context, state) {
        return switch (state) {
          TestLoading() => const Center(child: CircularProgressIndicator()),
          TestLoaded() => _LoadedView(state: state),
          TestError() => _ErrorView(state: state),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

// ─── Loaded ──────────────────────────────────────────────────────────────────

class _LoadedView extends StatelessWidget {
  final TestLoaded state;
  const _LoadedView({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TestCubit>();
    return Column(
      children: [
        _SearchHeader(state: state, cubit: cubit),
        Expanded(
          child: _TestList(state: state, cubit: cubit),
        ),
        _TotalBar(cubit: cubit),
      ],
    );
  }
}

class _SearchHeader extends StatelessWidget {
  final TestLoaded state;
  final TestCubit cubit;
  const _SearchHeader({required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: MyTextFormField(
              onChanged: cubit.searchTests,
              labelText: 'Search tests...',
            ),
          ),
          const SizedBox(width: 16),
          _CartBadge(count: state.selectedTests.length),
        ],
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  final int count;
  const _CartBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.shopping_cart, size: 30, color: AppColors.blue),
        if (count > 0)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class _TestList extends StatelessWidget {
  final TestLoaded state;
  final TestCubit cubit;
  const _TestList({required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    if (state.filteredTests.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No tests found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: state.filteredTests.length,
      itemBuilder: (_, index) {
        final test = state.filteredTests[index];
        // FIX: derive isSelected from state, not cubit method,
        // so it always reflects the latest BlocBuilder snapshot.
        final isSelected = state.selectedTests.any((t) => t.id == test.id);
        return _TestItem(
          test: test,
          isSelected: isSelected,
          onTap: () => cubit.toggleSelection(test),
        );
      },
    );
  }
}

class _TestItem extends StatelessWidget {
  final TestModel test;
  final bool isSelected;
  final VoidCallback onTap;

  const _TestItem({
    required this.test,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: isSelected ? AppColors.blue.withOpacity(0.12) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppColors.blue.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                test.name,
                style: AppFonts.subtitleBlackMedium.copyWith(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            Text(
              '${test.price.toStringAsFixed(0)} ₪',
              style: AppFonts.subtitleGreyMedium.copyWith(
                fontSize: 15,
                color: AppColors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                key: ValueKey(isSelected),
                color: isSelected ? AppColors.blue : Colors.grey.shade400,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalBar extends StatelessWidget {
  final TestCubit cubit;
  const _TotalBar({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: AppColors.blue.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Text(
        'Total: ${cubit.totalPrice.toStringAsFixed(2)} ₪',
        style: AppFonts.titleBlue.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ─── Error ───────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final TestError state;
  const _ErrorView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.read<TestCubit>().loadTests(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
