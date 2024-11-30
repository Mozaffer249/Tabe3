import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:tabee3_flutter/app/data/common/pdfapi.dart';
import 'package:tabee3_flutter/app/data/models/result_model.dart';
import 'package:http/http.dart' as http;

class PdfInvoiceApi {
  static Future<File> generate({
    var size,
    required ResultSummary result,
    required String studentName,
    required String className,
    required String schoolName,
    required String examName,
    required List<Result> resultsList,
  }) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final ttf = pw.Font.ttf(font);

    final imageBytes = await http.get(Uri.parse(result.image)).then((value) => value.bodyBytes);
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(MultiPage(
      // pageFormat: PdfPageFormat.a4,
      theme: ThemeData.withFont(
        base: ttf,
      ),
      orientation: PageOrientation.natural,
      build: (context) => [
        buildHeader(
            size, ttf, className, schoolName, examName, result, studentName,
            pw.Image(image, width: 70, height: 70)
        ),
        buildInvoice(resultsList, ttf),
        buildSigniture(schoolName, ttf)
      ],
      footer: (context) => buildFooter(ttf),
    ));

    return PdfApi.saveDocument(name: '$studentName$examName.pdf', pdf: pdf);
  }




  static pw.Widget buildHeader(var size, var tff, String className, schoolname,
          examName, ResultSummary resultSummary, studentName,pw.Image image) {


  return  pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          height: size.height * .2,
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text("بسم الله الرحمن الرحيم",
                      style: pw.TextStyle(fontSize: 12, font: tff),
                      textDirection: pw.TextDirection.rtl)
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                        margin: pw.EdgeInsets.all(size.width * .02),
                        decoration: pw.BoxDecoration(
                          // color: Colors.,
                          borderRadius: pw.BorderRadius.circular(4),
                          // border: Border.all(color: Colors.black54)
                        ),
                        height: size.height * .1,
                        width: size.width * .3,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text("ادارة التعليم الخاص",
                                style: pw.TextStyle(fontSize: 12, font: tff),
                                textDirection: pw.TextDirection.rtl),
                            pw.Text("نتيجة امتحان",
                                style: pw.TextStyle(fontSize: 12, font: tff),
                                textDirection: pw.TextDirection.rtl),
                            pw.Text(className,
                                style: pw.TextStyle(fontSize: 12, font: tff),
                                textDirection: pw.TextDirection.rtl),
                          ],
                        ),
                      ),
                    ],
                  ),

                  image,

                  pw.Row(
                    children: [
                      pw.Container(
                        margin: pw.EdgeInsets.all(size.width * .02),
                        decoration: pw.BoxDecoration(
                          // color: Colors.black,
                          borderRadius: pw.BorderRadius.circular(4),
                          // border: Border.all(color: Colors.black54)
                        ),
                        height: size.height * .1,
                        width: size.width * .3,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text("وزارة التربية والتعليم",
                                style: pw.TextStyle(fontSize: 9, font: tff),
                                textDirection: pw.TextDirection.rtl),
                            pw.Text("ولاية الخرطوم",
                                style: pw.TextStyle(fontSize: 9, font: tff),
                                textDirection: pw.TextDirection.rtl),
                            // Text("محلية شرق النيل",
                            //   style:TextStyle(fontSize: 9) ,),
                          ],
                        ),
                      ),
                      // Container(
                      //   child: PdfImage(pdfDocument, image: "image", width: 30, height: 30)
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        pw.Container(
          margin:
              pw.EdgeInsets.only(top: size.height * .01, left: size.width * .1),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(4),
            // border: Border.all(color: Colors.black54)
          ),
          height: size.height * .2,
          width: size.width,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Container(
                  margin: pw.EdgeInsets.only(left: size.width * .104),
                  child: pw.Column(children: [
                    pw.Text(schoolname,
                        style: pw.TextStyle(
                          fontSize: 12,
                          font: tff,
                        ),
                        textDirection: pw.TextDirection.rtl),
                    pw.Text(examName,
                        style: pw.TextStyle(fontSize: 12, font: tff),
                        textDirection: pw.TextDirection.rtl),
                  ])),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Container(
                    margin: pw.EdgeInsets.only(left: size.width * .20),
                    child: pw.Text("${studentName}",
                        style: pw.TextStyle(
                            fontSize: 12,
                            font: tff,
                            color: PdfColor.fromHex("10A3A8FF")),
                        textDirection: pw.TextDirection.rtl),
                  ),
                  pw.Text("Studen Name".tr + " : ",
                      style: pw.TextStyle(fontSize: 12, font: tff),
                      textDirection: pw.TextDirection.rtl),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('${resultSummary.percentage}%',
                      style: pw.TextStyle(
                          fontSize: 12,
                          font: tff,
                          color: PdfColor.fromHex("10A3A8FF")),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text("Percentage".tr + " : ",
                      style: pw.TextStyle(fontSize: 12, font: tff),
                      textDirection: pw.TextDirection.rtl),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("${resultSummary.grade}",
                      style: pw.TextStyle(
                          fontSize: 12,
                          font: tff,
                          color: PdfColor.fromHex("10A3A8FF")),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text("Grade".tr + " : ",
                      style: pw.TextStyle(fontSize: 12, font: tff),
                      textDirection: pw.TextDirection.rtl),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("${resultSummary.total}",
                      style: pw.TextStyle(
                          fontSize: 12,
                          font: tff,
                          color: PdfColor.fromHex("10A3A8FF")),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text("Total".tr + " : ",
                      style: pw.TextStyle(fontSize: 12, font: tff),
                      textDirection: pw.TextDirection.rtl),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget buildInvoice(
    List<Result> invoice,
    var tff,
  ) {
    return pw.Directionality(
        textDirection: TextDirection.ltr,
        child: pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          children: <pw.TableRow>[
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFF29C5CF)),
              children: <pw.Widget>[
                pw.Container(
                  margin: pw.EdgeInsets.only(right: 5),
                  child: pw.Text('obtained'.tr,
                      style: pw.TextStyle(
                          fontSize: 12,
                          font: tff,
                          color: PdfColor.fromInt(0xFFFFFFFF)),
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Container(
                  margin: pw.EdgeInsets.only(right: 5),
                  child: pw.Text('lowerClass'.tr,
                      style: pw.TextStyle(
                          fontSize: 12,
                          font: tff,
                          color: PdfColor.fromInt(0xFFFFFFFF)),
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Container(
                  margin: pw.EdgeInsets.only(right: 5),
                  child: pw.Text('topClass'.tr,
                      style: pw.TextStyle(
                          fontSize: 12,
                          font: tff,
                          color: PdfColor.fromInt(0xFFFFFFFF)),
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Container(
                  margin: pw.EdgeInsets.only(right: 5),
                  child: pw.Text('subject'.tr,
                      style: pw.TextStyle(
                          fontSize: 12,
                          font: tff,
                          color: PdfColor.fromInt(0xFFFFFFFF)),
                      textDirection: pw.TextDirection.rtl),
                ),
              ],
            ),
            ...invoice
                .asMap()
                .map((int key, Result value) => MapEntry(
                    key,
                    pw.TableRow(
                      decoration: pw.BoxDecoration(
                        color: key % 2 != 0
                            ? PdfColor.fromHex("8AE0E579")
                            : PdfColor.fromHex('F3F2F2F3'),
                      ),
                      children: <pw.Widget>[
                        pw.Container(
                          margin: pw.EdgeInsets.only(right: 5),
                          child: pw.Text('${value.obtainedMarks!}',
                              style: pw.TextStyle(fontSize: 12, font: tff),
                              textDirection: pw.TextDirection.rtl),
                        ),
                        pw.Container(
                          margin: pw.EdgeInsets.only(right: 5),
                          child: pw.Text('${value.minimumMarks!}',
                              style: pw.TextStyle(fontSize: 12, font: tff),
                              textDirection: pw.TextDirection.rtl),
                        ),
                        pw.Container(
                          margin: pw.EdgeInsets.only(right: 5),
                          child: pw.Text('${value.maximumMarks!}',
                              style: pw.TextStyle(fontSize: 12, font: tff),
                              textDirection: pw.TextDirection.rtl),
                        ),
                        pw.Container(
                          margin: pw.EdgeInsets.only(right: 5),
                          child: pw.Text('${value.subject!}',
                              style: pw.TextStyle(fontSize: 12, font: tff),
                              textDirection: pw.TextDirection.rtl),
                        ),
                      ],
                    )))
                .values
                .toList(),
          ],
        ));
  }

  static pw.Widget buildSigniture(schoolName, tff) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.SizedBox(height: 4 * PdfPageFormat.mm),
          pw.Text("توقيع مدير " + "$schoolName" + ".........................",
              style: pw.TextStyle(fontSize: 12, font: tff),
              textDirection: pw.TextDirection.rtl)
        ],
      );

  static pw.Widget buildFooter(var tff) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          Divider(),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Text("اي كشط أو تغيير  يلغي هذه النتيجة",
              style: pw.TextStyle(fontSize: 12, font: tff),
              textDirection: pw.TextDirection.rtl)
        ],
      );
}
