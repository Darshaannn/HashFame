import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';
import '../../../discovery/presentation/discovery_controller.dart';

class CreatorSearchEntryBar extends ConsumerStatefulWidget {
  const CreatorSearchEntryBar({super.key});

  @override
  ConsumerState<CreatorSearchEntryBar> createState() => _CreatorSearchEntryBarState();
}

class _CreatorSearchEntryBarState extends ConsumerState<CreatorSearchEntryBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerSearch(String query) {
    if (query.trim().isNotEmpty) {
      ref.read(creatorSearchFiltersProvider.notifier).update(
            (state) => state.copyWith(query: query.trim()),
          );
      ref.read(discoveryControllerProvider.notifier).search(initial: true);
    }
    context.push('/discover');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => context.push('/discover'),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: AppColors.burgundy,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Search creators, niches, interests...',
                    hintStyle: TextStyle(
                      fontFamily: AppTypography.hindFont,
                      fontSize: 13.5,
                      color: AppColors.secondaryGray,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    filled: false,
                  ),
                  style: const TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: _triggerSearch,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

