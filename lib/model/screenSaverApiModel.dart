class ScreenSaverMastersResponse {
  ScreenSaverMastersResponse({
    this.screenSaverMasters,
  });

  final List<ScreenSaverMaster>? screenSaverMasters;

  factory ScreenSaverMastersResponse.fromJson(Map<String, dynamic> json) =>
      ScreenSaverMastersResponse(
        screenSaverMasters: json["ScreenSaverMasters"] == null
            ? null
            : List<ScreenSaverMaster>.from(json["ScreenSaverMasters"]
                .map((x) => ScreenSaverMaster.fromJson(x))),
      );
}

class ScreenSaverMaster {
  ScreenSaverMaster({
    this.screenSaverId,
    this.name,
    this.animationDirectionId,
    this.imagePath,
    this.sliderText,
    this.description,
    this.displayOrder,
    this.screenSaverTypeId,
    this.videoPath,
    this.companyId,
    this.branchId,
    this.concessionaireId,
    this.isActive,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.ipAddress,
  });

  final String? screenSaverId;
  final String? name;
  final String? animationDirectionId;
  final String? imagePath;
  final String? sliderText;
  final String? description;
  final String? displayOrder;
  final String? screenSaverTypeId;
  final String? videoPath;
  final String? companyId;
  final String? branchId;
  final String? concessionaireId;
  final String? isActive;
  final String? createdBy;
  final String? createdDate;
  final String? updatedBy;
  final String? updatedDate;
  final String? ipAddress;

  factory ScreenSaverMaster.fromJson(Map<String, dynamic> json) =>
      ScreenSaverMaster(
        name: json["Name"],
        imagePath: json["ImagePath"],
      );
  Map<String, dynamic> toJson() => {
        "ScreenSaverID": screenSaverId,
        "ImagePath": imagePath,
      };
}
