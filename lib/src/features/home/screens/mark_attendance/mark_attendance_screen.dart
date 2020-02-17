import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/icons.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/widgets/app_back_button.dart';
import 'package:attendance_tracka/src/widgets/app_bar.dart';
import 'package:attendance_tracka/src/widgets/blur_bg_widget.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/modal.dart';
import 'package:attendance_tracka/src/widgets/screen.dart';
import 'package:attendance_tracka/src/widgets/shimmer_box.dart';
import 'package:attendance_tracka/src/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'mark_attendance_bloc/mark_attendance_bloc.dart';
import 'scan_qr_code_bloc/scan_qr_code_bloc.dart';

class MarkAttendanceScreen extends StatefulWidget {
  final int iteration;
  final String apiURL;
  MarkAttendanceScreen({Key key, this.apiURL, this.iteration})
      : assert(apiURL != null),
        assert(iteration != null),
        super(key: key);

  @override
  _MarkAttendanceScreenState createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final ValueNotifier<int> iter = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    ScanQRCodeBloc bloc = context.bloc();
    MarkAttendanceBloc markAttendanceBloc = context.bloc();
    final textTheme = Theme.of(context).textTheme;
    final mq = MediaQuery.of(context);
    return BlocConsumer<ScanQRCodeBloc, ScanQRCodeState>(listener: (context, state) {
      if (state is ScanQRCodeError) {
        // AppSnacks.showError(context, message: state.errorMessage);
      }
    }, builder: (context, state) {
      return BlocConsumer<MarkAttendanceBloc, MarkAttendanceState>(listener: (context, markAttendanceState) {
        if (markAttendanceState is MarkAttendanceError) {
          AppSnacks.showError(context, message: markAttendanceState.errorMessage);
        }
        if (markAttendanceState is MarkAttendanceSuccess) {
          showBluredModal(context,
              blur: true,
              barrierDismissble: false,
              padding: EdgeInsets.zero,
              height: 300,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppBorderRadius.large_all,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'ATTENDANCE MARKED',
                      style: textTheme.title.copyWith(fontWeight: FontWeight.w900),
                    ),
                    Expanded(child: Icon(Icons.check)),
                    SizedBox(height: 20),
                    Padding(
                      padding: AppPaddings.bodyH,
                      child: Text(
                        'The attendance for this participants has been marked!',
                        style: textTheme.subtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    AppButton(
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        bloc.add(ResetScanner());
                      },
                    )
                  ],
                ),
              ));
        }
      }, builder: (context, markAttendanceState) {
        return AppScreen(
          loading: markAttendanceState is MarkAttendanceLoading,
          child: Scaffold(
            appBar: AppAppBar(
              title: 'Mark Attendace',
              leading: AppBackButton(
                color: Colors.white,
              ),
            ),
            body: Column(
              children: <Widget>[
                Builder(builder: (context) {
                  return AspectRatio(
                    aspectRatio: 1 / 1,
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(),
                        padding: AppPaddings.lA,
                        child: ClipRRect(
                          borderRadius: AppBorderRadius.large_all,
                          child: Builder(builder: (context) {
                            if (state is ScanQRCodeError) {
                              return SizedBox.expand(
                                child: Container(
                                    padding: AppPaddings.lA,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.shade100.withOpacity(.3),
                                      borderRadius: AppBorderRadius.small_all,
                                    ),
                                    child: Column(children: <Widget>[
                                      Text(
                                        'ERROR',
                                        style: textTheme.title
                                            .copyWith(fontWeight: FontWeight.w900, color: AppColors.warning),
                                      ),
                                      Divider(),
                                      Expanded(
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                          //TODO GENERATE BARCODE
                                          Icon(AppIcons.qr_code, size: 100, color: AppColors.warning),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: AppPaddings.bodyH,
                                            child: Text(
                                              state.errorMessage,
                                              style: textTheme.subtitle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: AppPaddings.bodyA,
                                            child: SizedBox(
                                              width: 300,
                                              child: AppButton.white(
                                                child: Text('Retry'),
                                                onPressed: () {
                                                  bloc.add(ResetScanner());
                                                },
                                              ),
                                            ),
                                          )
                                        ]),
                                      )
                                    ])),
                              );
                            }
                            if (state is CodeScanned) {
                              return SizedBox.expand(
                                child: Container(
                                    padding: AppPaddings.lA,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.shade100.withOpacity(.3),
                                      borderRadius: AppBorderRadius.small_all,
                                    ),
                                    child: Column(children: <Widget>[
                                      Text(
                                        'SUCCESS',
                                        style: textTheme.title.copyWith(fontWeight: FontWeight.w900),
                                      ),
                                      Divider(),
                                      Expanded(
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                          //TODO GENERATE BARCODE
                                          Icon(
                                            AppIcons.qr_code,
                                            size: 100,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ...state.processedData.map((Map<String, String> data) {
                                                return Padding(
                                                  padding: AppPaddings.sV,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      text: "${data.keys.first}: ",
                                                      children: [
                                                        TextSpan(
                                                            text: "${data.values.first}",
                                                            style: TextStyle(fontWeight: FontWeight.w400)),
                                                      ],
                                                    ),
                                                    style: textTheme.subtitle.copyWith(fontWeight: FontWeight.w900),
                                                  ),
                                                );
                                              })
                                            ],
                                          ),
                                        ]),
                                      )
                                    ])),
                              );
                            }
                            return CameraMlVision<List<Barcode>>(
                              onDispose: () {},
                              overlayBuilder: (context) {
                                return BluredBgWidget(
                                  sigmaX: state is ScanQRCodeLoading ? 10 : 0,
                                  sigmaY: state is ScanQRCodeLoading ? 10 : 0,
                                  child: ShimmerBox(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          if (state is ScanQRCodeError)
                                            Icon(
                                              AppIcons.qr_code,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          Text(
                                            state is ScanQRCodeLoading
                                                ? "Processing"
                                                : "Scan QR Code to mark attendance",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              loadingBuilder: (_) => SizedBox.expand(child: ShimmerBox(child: SizedBox())),
                              detector: FirebaseVision.instance.barcodeDetector().detectInImage,
                              onResult: (List<Barcode> barcodes) {
                                if (barcodes.isNotEmpty && state is! ScanQRCodeLoading) {
                                  bloc.add(OnCodeScanned(barcodes.first));
                                }
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                }),
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: iter,
                    builder: (context, iterValue, _) {
                      if (state is CodeScanned) {
                        return Column(
                          children: <Widget>[
                            Container(
                              margin: AppPaddings.lA,
                              padding: AppPaddings.lH,
                              decoration: BoxDecoration(borderRadius: AppBorderRadius.large_all, border: Border.all()
                                  // color: TTColors.lighterGrey.withOpacity(.5),
                                  ),
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              height: kToolbarHeight,
                              child: DropdownButton<int>(
                                  underline: const SizedBox(),
                                  hint: Text(
                                    'SELECT MEETUP',
                                    textAlign: TextAlign.center,
                                    style: textTheme.body1.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  value: iterValue,
                                  isDense: false,
                                  isExpanded: true,
                                  icon: Icon(
                                    AppIcons.chevron_down,
                                    size: 30,
                                    color: AppColors.secondary,
                                  ),
                                  elevation: 2,
                                  items: [
                                    ...List.generate(
                                        widget.iteration,
                                        (iteration) => DropdownMenuItem(
                                              value: iteration,
                                              child: Text(
                                                'MEETUP ${iteration + 1} ',
                                                textAlign: TextAlign.center,
                                                style: textTheme.body1.copyWith(fontSize: 16),
                                              ),
                                            ))
                                  ],
                                  onChanged: (val) {
                                    iter.value = val;
                                  }),
                            ),
                            Padding(
                              padding: AppPaddings.lH,
                              child: AppButton(
                                child: Text('MARK ATTENDANCE', style: textTheme.button.copyWith(color: Colors.white)),
                                onPressed: () {
                                  if (iterValue == null) {
                                    return AppSnacks.showError(context, message: 'Please select meetup day');
                                  }
                                  markAttendanceBloc.add(AttendanceMarked(
                                    apiURL: widget.apiURL,
                                    email: state.email,
                                    interation: iterValue + 1,
                                  ));
                                },
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: AppPaddings.lH,
                              child: FlatButton(
                                child: Text('RESET',
                                    style: textTheme.button.copyWith(color: AppColors.text.withOpacity(.7))),
                                onPressed: () {
                                  bloc.add(ResetScanner());
                                },
                              ),
                            ),
                            SizedBox(height: 16)
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      });
    });
  }
}
