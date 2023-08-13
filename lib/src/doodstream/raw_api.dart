part of '../doodstream.dart';

class _DoodstreamRawApi {
  _DoodstreamRawApi(this._apiKey) {
    if (ApiConfig.printLog) {
      _client.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  final String _apiKey;
  final String _base = 'doodapi.com';

  final _client = RawHttp();

  Uri _apiUri(String unencodedPath, [Map<String, dynamic>? queryParameters]) =>
      Uri.https(
        _base,
        '/api/$unencodedPath',
        <String, dynamic>{'key': _apiKey}
          ..addAll(queryParameters ?? {})
          ..removeWhere((_, v) => v == null),
      );

  Future<String?> accountInfo() async {
    final fetch = await _client.getUri(_apiUri('account/info'));
    return fetch;
  }

  Future<String?> accountReports({
    int? lastXDaysReport,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final fetch = await _client.getUri(
      _apiUri('account/stats', {
        'last': '$lastXDaysReport',
        'from_date': fromDate?.toJiffy.toYYYYMMDD,
        'to_date': toDate?.toJiffy.toYYYYMMDD,
      }),
    );
    return fetch;
  }

  Future<String?> dmcaList() async {
    final fetch = await _client.getUri(_apiUri('dmca/list'));
    return fetch;
  }

  Future<String?> getUploadServer() async =>
      _client.getUri(_apiUri('upload/server'));

  Future<String?> localUpload(File file, String uploadServer) async {
    final id = await file.id;
    final name = file.fileNameAndExt;

    final files = [MapEntry('file', await file.toMultipart)];
    final fields = [MapEntry('api_key', _apiKey)];

    final fetch = await _client.post(
      '$uploadServer?$_apiKey',
      fields: fields,
      files: files,
      fileTransferProgress: FileTransferProgress(
        id,
        type: ServiceType.doodstream,
        name: name,
        isUpload: true,
      ),
    );

    return fetch;
  }

  Future<String?> clone(
    String fileCode, {
    String? folderId,
  }) async {
    final fetch = await _client.getUri(
      _apiUri('file/clone', {
        'file_code': fileCode,
        'fld_id': folderId,
      }),
    );
    return fetch;
  }

  Future<String?> remoteUpload(
    String url, {
    String? newTitle,
    String? folderId,
  }) async {
    final fetch = await _client.getUri(
      _apiUri('upload/url', {
        'url': url,
        'new_title': newTitle,
        'fld_id': folderId,
      }),
    );
    return fetch;
  }

  Future<String?> remoteUploadList() async {
    final fetch = await _client.getUri(_apiUri('urlupload/list'));
    return fetch;
  }

  Future<String?> remoteUploadStatus(
    String fileCode,
  ) async {
    final fetch = await _client.getUri(
      _apiUri('urlupload/status', {
        'file_code': fileCode,
      }),
    );
    return fetch;
  }

  Future<String?> remoteUploadSlot() async {
    final fetch = await _client.getUri(_apiUri('urlupload/slots'));
    return fetch;
  }

  Future<String?> remoteUploadAction({
    required bool isRestartErrors,
    required bool isClearErrors,
    required bool isClearAll,
    String? toBeDeletedRemoteUploadFileCode,
  }) async {
    final restartErrors = isRestartErrors.toStringFlag;
    final clearErrors = isClearErrors.toStringFlag;
    final clearAll = isClearAll.toStringFlag;

    final fetch = await _client.getUri(
      _apiUri('urlupload/actions', {
        'restart_errors': restartErrors,
        'clear_errors': clearErrors,
        'clear_all': clearAll,
        'delete_code': toBeDeletedRemoteUploadFileCode,
      }),
    );
    return fetch;
  }

  Future<String?> createFolder(
    String folderName, {
    String? parentId,
  }) async {
    final fetch = await _client.getUri(
      _apiUri('folder/create', {
        'name': folderName,
        'parent_id': parentId,
      }),
    );
    return fetch;
  }

  Future<String?> renameFolder(
    String newName, {
    required String folderId,
  }) async {
    final fetch = await _client.getUri(
      _apiUri('folder/rename', {
        'name': newName,
        'fld_id': folderId,
      }),
    );
    return fetch;
  }

  Future<String?> listFiles({
    String? page,
    String? videosPerPage,
    String? folderId,
  }) async {
    final fetch = await _client.getUri(
      _apiUri('file/list', {
        'page': page,
        'per_page': videosPerPage,
        'fld_id': folderId,
      }),
    );
    return fetch;
  }

  Future<String?> fileStatus(
    String fileCode,
  ) async {
    final fetch = await _client.getUri(
      _apiUri('file/check', {
        'file_code': fileCode,
      }),
    );
    return fetch;
  }

  Future<String?> fileInfo(
    String fileCode,
  ) async {
    final fetch = await _client.getUri(
      _apiUri('file/info', {
        'file_code': fileCode,
      }),
    );
    return fetch;
  }

  Future<String?> fileImage(
    String fileCode,
  ) async {
    final fetch = await _client.getUri(
      _apiUri('file/image', {
        'file_code': fileCode,
      }),
    );
    return fetch;
  }

  Future<String?> fileRename(
    String newName, {
    required String fileCode,
  }) async {
    final fetch = await _client.getUri(
      _apiUri('file/rename', {
        'title': newName,
        'file_code': fileCode,
      }),
    );
    return fetch;
  }

  Future<String?> fileSearch(String query) async {
    final fetch = await _client.getUri(
      _apiUri('search/videos', {
        'search_term': query,
      }),
    );
    return fetch;
  }
}
