import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user.dart';
import '../models/transaction.dart';
import '../models/biller.dart';
import '../models/airtime_package.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://localhost:3000/api')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Auth endpoints
  @POST('/auth/login')
  Future<HttpResponse<Map<String, dynamic>>> login(@Body() Map<String, dynamic> body);

  @POST('/auth/register')
  Future<HttpResponse<User>> register(@Body() Map<String, dynamic> body);

  @POST('/auth/logout')
  Future<HttpResponse<void>> logout(@Header('Authorization') String token);

  // User endpoints
  @GET('/users/{userId}')
  Future<HttpResponse<User>> getUser(
    @Path('userId') String userId,
    @Header('Authorization') String token,
  );

  @PUT('/users/{userId}')
  Future<HttpResponse<User>> updateUser(
    @Path('userId') String userId,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String token,
  );

  @PATCH('/users/{userId}/balance')
  Future<HttpResponse<User>> updateBalance(
    @Path('userId') String userId,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String token,
  );

  // Transaction endpoints
  @GET('/transactions')
  Future<HttpResponse<List<Transaction>>> getTransactions(
    @Header('Authorization') String token,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('type') String? type,
  );

  @GET('/transactions/{userId}')
  Future<HttpResponse<List<Transaction>>> getUserTransactions(
    @Path('userId') String userId,
    @Header('Authorization') String token,
    @Query('page') int? page,
    @Query('limit') int? limit,
  );

  @POST('/transactions/send')
  Future<HttpResponse<Transaction>> sendMoney(
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String token,
  );

  @POST('/transactions/airtime')
  Future<HttpResponse<Transaction>> buyAirtime(
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String token,
  );

  @POST('/transactions/bill')
  Future<HttpResponse<Transaction>> payBill(
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String token,
  );

  @POST('/transactions/bank')
  Future<HttpResponse<Transaction>> sendToBank(
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String token,
  );

  // Biller endpoints
  @GET('/billers')
  Future<HttpResponse<List<Biller>>> getBillers(@Header('Authorization') String token);

  @GET('/billers/{billerId}')
  Future<HttpResponse<Biller>> getBiller(
    @Path('billerId') String billerId,
    @Header('Authorization') String token,
  );

  // Airtime packages
  @GET('/airtime-packages')
  Future<HttpResponse<List<AirtimePackage>>> getAirtimePackages(
    @Header('Authorization') String token,
  );

  // Bank list
  @GET('/banks')
  Future<HttpResponse<List<String>>> getBanks(@Header('Authorization') String token);

  // Dashboard
  @GET('/dashboard/{userId}')
  Future<HttpResponse<Map<String, dynamic>>> getDashboard(
    @Path('userId') String userId,
    @Header('Authorization') String token,
  );
}