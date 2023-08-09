// ignore_for_file: argument_type_not_assignable, avoid_dynamic_calls

part of '../main.dart';

class RemoteUploadAdd {
  RemoteUploadAdd({
    this.msg,
    this.result,
    this.status,
  });

  factory RemoteUploadAdd.fromJson(String str) =>
      RemoteUploadAdd.fromMap(json.decode(str));

  factory RemoteUploadAdd.fromMap(Map<String, dynamic> json) => RemoteUploadAdd(
        msg: json['msg'],
        result: json['result'] == null
            ? null
            : RemoteUploadAddResult.fromMap(json['result']),
        status: json['status'],
      );
  final String? msg;
  final RemoteUploadAddResult? result;
  final int? status;

  RemoteUploadAdd copyWith({
    String? msg,
    RemoteUploadAddResult? result,
    int? status,
  }) =>
      RemoteUploadAdd(
        msg: msg ?? this.msg,
        result: result ?? this.result,
        status: status ?? this.status,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'msg': msg,
        'result': result?.toMap(),
        'status': status,
      };
}

class RemoteUploadAddResult {
  RemoteUploadAddResult({
    this.folderid,
    this.id,
  });

  factory RemoteUploadAddResult.fromJson(String str) =>
      RemoteUploadAddResult.fromMap(json.decode(str));

  factory RemoteUploadAddResult.fromMap(Map<String, dynamic> json) =>
      RemoteUploadAddResult(
        folderid: json['folderid'],
        id: json['id'],
      );
  final String? folderid;
  final String? id;

  RemoteUploadAddResult copyWith({
    String? folderid,
    String? id,
  }) =>
      RemoteUploadAddResult(
        folderid: folderid ?? this.folderid,
        id: id ?? this.id,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'folderid': folderid,
        'id': id,
      };
}
