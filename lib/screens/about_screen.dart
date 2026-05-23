import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _gallery = [
    'https://picsum.photos/seed/chx-gallery-1/400/300',
    'https://picsum.photos/seed/chx-gallery-2/400/300',
    'https://picsum.photos/seed/chx-gallery-3/400/300',
    'https://picsum.photos/seed/chx-gallery-4/400/300',
  ];

  static const _guests = [
    ('Толибжон ака', 'Поваром отдельное спасибо', 'https://picsum.photos/seed/guest-1/200/200'),
    ('Илхомжон', 'Поваром отдельное спасибо', 'https://picsum.photos/seed/guest-2/200/200'),
    ('Карим', 'Самое вкусное место!', 'https://picsum.photos/seed/guest-3/200/200'),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.creamSoft,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _Header(title: l.aboutUs, onClose: () => Navigator.of(context).maybePop()),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    children: [
                      Center(
                        child: Text(
                          l.aboutUs,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          l.aboutUsBody,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.45,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 16 / 10,
                              child: CachedNetworkImage(
                                imageUrl: 'https://picsum.photos/seed/chx-video/600/400',
                                fit: BoxFit.cover,
                                placeholder: (_, _) => Container(color: AppColors.divider),
                                errorWidget: (_, _, _) => Container(color: AppColors.divider),
                              ),
                            ),
                          ),
                          Container(
                            width: 56,
                            height: 56,
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          l.guestsAboutUs,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 140,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _guests.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 16),
                          itemBuilder: (_, i) {
                            final (name, quote, img) = _guests[i];
                            return SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: SizedBox(
                                      width: 76,
                                      height: 76,
                                      child: CachedNetworkImage(
                                        imageUrl: img,
                                        fit: BoxFit.cover,
                                        placeholder: (_, _) => Container(color: AppColors.divider),
                                        errorWidget: (_, _, _) => Container(color: AppColors.divider),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    name,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '"$quote"',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          l.gallery,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          l.galleryDescription,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.45,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: _gallery.length,
                        itemBuilder: (_, i) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: _gallery[i],
                            fit: BoxFit.cover,
                            placeholder: (_, _) => Container(color: AppColors.divider),
                            errorWidget: (_, _, _) => Container(color: AppColors.divider),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onClose});
  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
      child: Row(
        children: [
          const SizedBox(width: 36),
          Expanded(
            child: Center(
              child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(color: AppColors.divider, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 16, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
