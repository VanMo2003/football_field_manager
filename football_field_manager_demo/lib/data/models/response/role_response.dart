
import 'permission_response.dart';

class RoleResponse {
  String? name;
  String? description;
  List<PermissionResponse>? permissions;

  RoleResponse({this.name, this.description, this.permissions});

  RoleResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['permissions'] != null) {
      permissions = <PermissionResponse>[];
      json['permissions'].forEach((v) {
        permissions!.add(new PermissionResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
