import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_card.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/features/partner-finding/ui/partner_detail_screen.dart';
import 'package:play_tennis_hk/features/partner-finding/ui/partner_info_cell.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class PartnerListScreen extends ConsumerStatefulWidget {
  const PartnerListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PartnerListScreenState();
}

class PartnerListScreenState extends ConsumerState<PartnerListScreen> {
  Future refresh() async {}

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 4,
          scrollDirection: Axis.vertical,
          // shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: const CustomCard(
                child: PartnerInfoCell(
                  userProfile: UserProfile(
                    username: "Jones",
                    districts: [
                      District.centralAndWestern,
                      District.eastern,
                    ],
                    email: "ahha@asdsa.com",
                    ntrpLevel: 3.5,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PartnerDetailScreen(
                      userProfile: UserProfile(
                        username: "Jones",
                        districts: [
                          District.centralAndWestern,
                          District.eastern
                        ],
                        email: "ahha@asdsa.com",
                        ntrpLevel: 3.5,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
