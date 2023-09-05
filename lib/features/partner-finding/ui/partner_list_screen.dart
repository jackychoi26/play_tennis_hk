import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_card.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:play_tennis_hk/components/scrollable_error_text.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/features/partner-finding/domain/providers/partners_offset_provider.dart';
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
  num currentValueLength = 0;

  Future refresh() async {
    ref.read(partnersProvider.notifier).clearPartners();
    ref.read(partnersOffsetProvider.notifier).resetOffset();
    final offset = ref.read(partnersOffsetProvider);
    ref.read(partnersProvider.notifier).getPublicProfiles(offset: offset);
  }

  void loadMore() {
    ref.read(partnersOffsetProvider.notifier).incrementOffset();
    final offset = ref.read(partnersOffsetProvider);
    ref.read(partnersProvider.notifier).getPublicProfiles(offset: offset);
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
          loading: () => const Center(child: CupertinoActivityIndicator()),
          data: (value) {
            if (value.isEmpty) {
              return Center(
                child: ListView(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 250),
                        child: CustomText(
                            AppLocalizations.of(context)?.noPartnersNow),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                  right: 8,
                  bottom: 100,
                ),
                itemCount: value.length + 1,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  if (index == value.length) {
                    if (value.length == currentValueLength) {
                      return const SizedBox();
                    }

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        currentValueLength = value.length;
                      });
                      loadMore();
                    });

                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CupertinoActivityIndicator()),
                    );
                  }
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
            }
          },
          error: (err, st) => const ScrollableErrorText(),
        ),
      ),
    );
  }
}
