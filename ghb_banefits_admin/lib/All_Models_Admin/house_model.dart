import 'package:cloud_firestore/cloud_firestore.dart';

class HouseAllowanceAdmin {
  final int no;
  final String empcode;
  final String name;
  final String department;
  final String divisionment;
  final String savedate;
  final String startdate;
//
  final String position;
  final String segment;
  final String departmentwork;
  final String provincework;
  final String positiondate;
//
  final String typehouse;
  final String moneyhouse;

  final String housenumber;
  final String alley;
  final String road;
  final String district;
  final String county;
  final String province;
  final String workstatus;
//
  ///
  late String payamount;
  late String paydate;
  late String status;
  final String email;
  final String fileUrl;
  final String filename;
  late String flagread;
  String id;
  late String remarks;
  HouseAllowanceAdmin(
    this.no,
    this.empcode,
    this.name,
    this.department,
    this.divisionment,
    this.savedate,
    this.startdate,
    this.position,
    this.segment,
    this.departmentwork,
    this.provincework,
    this.positiondate,
    this.typehouse,
    this.moneyhouse,
    this.housenumber,
    this.alley,
    this.road,
    this.district,
    this.county,
    this.province,
    this.workstatus,
    this.payamount,
    this.paydate,
    this.status,
    this.email,
    this.fileUrl,
    this.filename,
    this.flagread,
    this.id,
    this.remarks,
  );

  factory HouseAllowanceAdmin.fromJson(Map<String, dynamic> json) {
    print(json);
    return HouseAllowanceAdmin(
      json['no'] as int,
      json['empcode'] as String,
      json['name'] as String,
      json['department'] as String,
      json['divisionment'] as String,
      json['savedate'] as String,
      json['startdate'] as String,
      json['position'] as String,
      json['segment'] as String,
      json['departmentwork'] as String,
      json['provincework'] as String,
      json['positiondate'] as String,
      json['typehouse'] as String,
      json['moneyhouse'] as String,
      json['housenumber'] as String,
      json['alley'] as String,
      json['road'] as String,
      json['district'] as String,
      json['county'] as String,
      json['province'] as String,
      json['workstatus'] as String,
      json['payamount'] as String,
      json['paydate'] as String,
      json['status'] as String,
      json['email'] as String,
      json['fileUrl'] as String,
      json['filename'] as String,
      json['flagread'] as String,
      json['id'] as String,
      json['remarks'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'empcode': empcode,
      'name': name,
      'department': department,
      'divisionment': divisionment,
      'savedate': savedate,
      'startdate': startdate,
      'position': position,
      'segment': segment,
      'departmentwork': departmentwork,
      'provincework': provincework,
      'positiondate': positiondate,
      'typehouse': typehouse,
      'housenumber': housenumber,
      'alley': alley,
      'road': road,
      'district': district,
      'county': county,
      'province': province,
      'workstatus': workstatus,
      'payamount': payamount,
      'paydate': paydate,
      'status': status,
      'email': email,
      'fileUrl': fileUrl,
      'filename': filename,
      'flagread': flagread,
      'id': id,
      'remarks': remarks,
    };
  }
}

class AllHouseAllowanceAdmin {
  final List<HouseAllowanceAdmin> houses;

  AllHouseAllowanceAdmin(this.houses);
  factory AllHouseAllowanceAdmin.fromJson(List<dynamic> json) {
    List<HouseAllowanceAdmin> houses;
    houses = json.map((item) => HouseAllowanceAdmin.fromJson(item)).toList();
    return AllHouseAllowanceAdmin(houses);
  }
  factory AllHouseAllowanceAdmin.fromSnapshot(QuerySnapshot s) {
    List<HouseAllowanceAdmin> houses = s.docs.map((DocumentSnapshot ds) {
      HouseAllowanceAdmin house =
          HouseAllowanceAdmin.fromJson(ds.data() as Map<String, dynamic>);
      //order.no = ds.id.substring(1, 8);
      // print(ds.id);
      return house;
    }).toList();

    return AllHouseAllowanceAdmin(houses);
  }
}
