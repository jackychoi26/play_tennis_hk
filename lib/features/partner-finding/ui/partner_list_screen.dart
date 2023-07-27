import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_card.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_error_text.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/features/partner-finding/domain/providers/partners_provider.dart';
import 'package:play_tennis_hk/features/partner-finding/ui/partner_detail_screen.dart';
import 'package:play_tennis_hk/features/partner-finding/ui/partner_info_cell.dart';

class PartnerListScreen extends ConsumerStatefulWidget {
  const PartnerListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PartnerListScreenState();
}

class PartnerListScreenState extends ConsumerState<PartnerListScreen> {
  Future refresh() async {
    ref.read(partnersProvider.notifier).getPublicProfiles();
  }

  @override
  Widget build(BuildContext context) {
    final partners = ref.watch(partnersProvider);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.findPartner,
          textType: CustomTextType.subtitle,
        ),
      ),
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: partners.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (value) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
                right: 8,
                bottom: 100,
              ),
              itemCount: value.length,
              scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final userProfile = value[index];

                return InkWell(
                  child: CustomCard(
                    child: PartnerInfoCell(userProfile: userProfile),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PartnerDetailScreen(
                          userProfile: userProfile,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          error: (err, st) => const CustomErrorText(),
        ),
      ),
    );
  }
}
