import 'package:cloud_firestore/cloud_firestore.dart';

class HouseAllowance {
  final int  no;
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
  final String payamount;
  final String paydate;
  final String status;
  final String email;
    final String fileUrl;
  final String filename;
  final String  flagread;
  String id;
    final String   remarks;
  HouseAllowance(this.no,this.empcode, this.name, this.department, this.divisionment, this.savedate, this.startdate, 
  this.position, this.segment, this.departmentwork, this.provincework, this.positiondate, 
  this.typehouse, this.moneyhouse, this.housenumber, this.alley, this.road, this.district, this.county, this.province, this.workstatus, 
  this.payamount, this.paydate, this.status, this.email,       this.fileUrl,
       this.filename,
       this.flagread,
       this.id, this.remarks,
);

  factory HouseAllowance.fromJson(Map<String, dynamic> json) {
        print(json);
    return HouseAllowance(
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
          'fileUrl' : fileUrl, 
    'filename' : filename,    
    'flagread' : flagread,   
    'id' : id,
        'remarks' : remarks, 
    };
  }

}

class AllHouseAllowance {
  final List<HouseAllowance> houses;

  AllHouseAllowance(this.houses);
  factory AllHouseAllowance.fromJson(List<dynamic> json) {
    List<HouseAllowance> houses;
    houses = json.map((item) => HouseAllowance.fromJson(item)).toList();
    return AllHouseAllowance(houses);
  }
  factory AllHouseAllowance.fromSnapshot(QuerySnapshot s) {
    List<HouseAllowance> houses = s.docs.map((DocumentSnapshot ds) {
      HouseAllowance house =
          HouseAllowance.fromJson(ds.data() as Map<String, dynamic>);
      //order.no = ds.id.substring(1, 8);
      // print(ds.id);
      return house;
    }).toList();

    return AllHouseAllowance(houses);
  }
}
