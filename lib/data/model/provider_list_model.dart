class ProviderListModel {
  bool success;
  String message;
  int currentPage;
  List<Datum> data;

  ProviderListModel({
    required this.success,
    required this.message,
    required this.currentPage,
    required this.data,
  });

  factory ProviderListModel.fromJson(Map<String, dynamic> json) =>
      ProviderListModel(
        success: json["success"],
        message: json["message"],
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  String uuid;
  String businessName;
  dynamic categoryId;
  String vatNo;
  String regNo;
  String idNo;
  String type;
  String email;
  String phone;
  String note;
  String webLink;
  int highlight;
  String category;
  dynamic keyword;
  String imagePath;
  String backgroundImagePath;
  FileClass file;
  Cashback cashback;

  Datum({
    required this.uuid,
    required this.businessName,
    required this.categoryId,
    required this.vatNo,
    required this.regNo,
    required this.idNo,
    required this.type,
    required this.email,
    required this.phone,
    required this.note,
    required this.webLink,
    required this.highlight,
    required this.category,
    required this.keyword,
    required this.imagePath,
    required this.backgroundImagePath,
    required this.file,
    required this.cashback,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uuid: json["uuid"],
        businessName: json["business_name"] ?? "",
        categoryId: json["category_id"],
        vatNo: json["vat_no"],
        regNo: json["reg_no"] ?? "",
        idNo: json["id_no"] ?? "",
        type: json["type"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        note: json["note"] ?? "",
        webLink: json["web_link"] ?? "",
        highlight: json["highlight"] ?? "",
        category: json["category"] ?? "",
        keyword: json["keyword"],
        imagePath: json["image_path"] ?? "",
        backgroundImagePath: json["background_image_path"] ?? "",
        file: FileClass.fromJson(json["file"]),
        cashback: Cashback.fromJson(json["cashback"]),
      );
}

class Cashback {
  String uuid;
  String providerUuid;
  int percentage;
  DateTime startDate;

  Cashback({
    required this.uuid,
    required this.providerUuid,
    required this.percentage,
    required this.startDate,
  });

  factory Cashback.fromJson(Map<String, dynamic> json) => Cashback(
        uuid: json["uuid"],
        providerUuid: json["provider_uuid"],
        percentage: json["percentage"] ?? 0,
        startDate: DateTime.parse(json["start_date"]),
      );
}

class FileClass {
  int id;
  String uuid;
  String name;
  String extension;
  String creatorUuid;
  DateTime createdAt;
  DateTime updatedAt;
  String backgroundImage;

  FileClass({
    required this.id,
    required this.uuid,
    required this.name,
    required this.extension,
    required this.creatorUuid,
    required this.createdAt,
    required this.updatedAt,
    required this.backgroundImage,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"] ?? "",
        extension: json["extension"] ?? "",
        creatorUuid: json["creator_uuid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        backgroundImage: json["background_image"] ?? "",
      );
}
