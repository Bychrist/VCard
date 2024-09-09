const String tableContact = 'tbl_contace';
const String tblContactColId = 'id';
const String tblContactColName = 'name';
const String tblContactColEmail = 'email';
const String tblContactColCompany = 'company';
const String tblContactColDesignation = 'designation';
const String tblContactColAddress = 'address';
const String tblContactColWebsite = 'website';
const String tblContactColImage = 'image';
const String tblContactColFavorite = 'favorite';
const String tblContactColMobile = 'mobile';

class ContactModel {
  int id;
  String name;
  String mobile;
  String email;
  String company;
  String designation;
  String address;
  String website;
  String image;
  bool favorite;

  ContactModel({
    this.id = -1,
    required this.name,
    required this.mobile,
    this.email = '',
    this.company = '',
    this.designation = '',
    this.address = '',
    this.website = '',
    this.image = '',
    this.favorite = false,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactColName: name,
      tblContactColMobile: mobile,
      tblContactColEmail: email,
      tblContactColAddress: address,
      tblContactColWebsite: website,
      tblContactColDesignation: designation,
      tblContactColCompany: company,
      tblContactColFavorite: favorite ? 1 : 0,
      tblContactColImage: image,
    };

    if (id > 0) {
      map[tblContactColId] = id;
    }

    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
      id: map[tblContactColId],
      name: map[tblContactColName],
      mobile: map[tblContactColMobile],
      email: map[tblContactColEmail],
      address: map[tblContactColAddress],
      designation: map[tblContactColDesignation],
      company: map[tblContactColCompany],
      website: map[tblContactColWebsite],
      favorite: map[tblContactColFavorite] == 1 ? true : false);
}
