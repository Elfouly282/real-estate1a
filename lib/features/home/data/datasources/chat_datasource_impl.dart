import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/api/api_manager.dart';
import 'package:real_estate_1a/core/constant/app_constants.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/home/data/models/chat_model.dart';
import 'package:real_estate_1a/features/home/domain/entities/chat_entity.dart';
import 'package:real_estate_1a/features/home/domain/repositories/datasource/chat_datasource.dart';

@Injectable(as: ChatDatasource)
class ChatDatasourceImpl implements ChatDatasource {
  final ApiManager apiManager;

  ChatDatasourceImpl({required this.apiManager});

  DataModel _conversationFromResponse(dynamic responseData) {
    final data = responseData is Map<String, dynamic> &&
            responseData['data'] != null
        ? responseData['data']
        : responseData;

    return DataModel.fromJson(data as Map<String, dynamic>);
  }

  List<DataModel> _conversationListFromResponse(dynamic responseData) {
    final data = responseData is Map<String, dynamic> &&
            responseData['data'] != null
        ? responseData['data']
        : responseData;

    return (data as List)
        .map((item) => DataModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Either<Failure, ConversationEntity>> getConversationAndMessage(
      int conversationId) async {
    try {
      final response = await apiManager.getData(
        url: AppConstants.RealEstatebaseUrl +
            AppConstants.getMessageAndConversation(conversationId),
      );

      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        return Left(ServerException(
          'Failed to load Chat: ${response.statusCode}',
        ));
      }

      final data = _conversationFromResponse(response.data);

      return Right(data);
    } catch (e) {
      return Left(ServerException('Failed to load chat: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversationList() async {
    try {
      final response = await apiManager.getData(
        url: AppConstants.RealEstatebaseUrl +
            AppConstants.getListConversation,
      );

      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        return Left(ServerException(
          'Failed to load chat: ${response.statusCode}',
        ));
      }

      final data = _conversationListFromResponse(response.data);

      return Right(data);
    } catch (e) {
      return Left(ServerException('Failed to load chat: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
      int conversationId, String message) async {
    try {
      final response = await apiManager.post(
        url: AppConstants.RealEstatebaseUrl +
            AppConstants.sendMessage(conversationId),
        data: {"body": message},
      );

      final status = response.statusCode ?? 0;

      if (status >= 200 && status < 300) {
        return const Right(unit);
      }

      return Left(ServerException('Failed: $status'));
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> startConversation(
      int agentUserId, int propertyId) async {
    try {
      final response = await apiManager.post(
        url: AppConstants.RealEstatebaseUrl +
            AppConstants.getListConversation,
        data: {
          "agent_user_id": agentUserId,
          "property_id": propertyId,
        },
      );

      final status = response.statusCode ?? 0;

      if (status >= 200 && status < 300) {
        return Right(_conversationFromResponse(response.data));
      }

      return Left(ServerException('Failed: $status'));
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}
