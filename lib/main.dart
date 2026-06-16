import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_link/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:pharma_link/features/medicine/data/datasource/medicine_remote_datasource_impl.dart';
import 'package:pharma_link/features/medicine/data/repository/medicine_repository_impl.dart';
import 'package:pharma_link/features/medicine/presentation/getMedicine/cubit/get_medicine_cubit.dart';
import 'core/app_setting/theme/app_theme.dart';
import 'core/network/api_client.dart';
import 'features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/usecase/login_use_case.dart';
import 'features/auth/domain/usecase/register_use_case.dart';
import 'features/auth/presentation/login/cubit/login_cubit.dart';
import 'features/auth/presentation/login/view/login_screen.dart';
import 'features/auth/presentation/register/cubit/register_cubit.dart';
import 'features/medicine/domain/usecase/get_medicine_by_id_use_case.dart';
import 'features/medicine/domain/usecase/get_medicines_use_case.dart';
import 'features/medicine/presentation/getMedicine/view/get_medicines_screen.dart';
import 'features/medicine/presentation/getMedicineById/cubit/get_medicine_by_id_cubit.dart';
import 'features/order/data/datasource/order_remote_datasource_impl.dart';
import 'features/order/data/repository/order_repository_impl.dart';
import 'features/order/domain/usecase/create_order_use_case.dart';
import 'features/order/domain/usecase/delete_order_use_case.dart';
import 'features/order/domain/usecase/get_order_by_id_use_case.dart';
import 'features/order/domain/usecase/get_orders_use_case.dart';
import 'features/order/presentation/cancelOrder/cubit/cancel_order_cubit.dart';
import 'features/order/presentation/createOrder/cubit/create_order_cubit.dart';
import 'features/order/presentation/createOrder/view/create_order_screen.dart';
import 'features/order/presentation/getMyOrder/cubit/get_my_order_cubit.dart';
import 'features/order/presentation/getMyOrder/view/get_my_order_screen.dart';
import 'features/order/presentation/getOrderById/cubit/get_order_by_id_cubit.dart';
import 'features/splash/presentation/view/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.init();

  final authRemoteDatasource = AuthRemoteDatasourceImpl();
  final authRepository = AuthRepositoryImpl(
    authRemoteDatasource: authRemoteDatasource,
  );
  final medicineRemoteDatasource = MedicineRemoteDatasourceImpl();
  final medicineRepository = MedicineRepositoryImpl(
    medicineRemoteDatasource: medicineRemoteDatasource,
  );
  final orderRemoteDatasource = OrderRemoteDatasourceImpl();

  final orderRepository = OrderRepositoryImpl(
    orderRemoteDatasource: orderRemoteDatasource,
  );
  final loginUsecase = LoginUseCase(authRepository: authRepository);
  final registerUsecase = RegisterUseCase(authRepository: authRepository);
  final getMedicinesUsecase = GetMedicinesUseCase(
    medicineRepository: medicineRepository,
  );
  final getMedicineByIdUseCase = GetMedicineByIdUseCase(
    medicineRepository: medicineRepository,
  );
  final createOrderUseCase = CreateOrderUseCase(
    orderRepository: orderRepository,
  );
  final deleteOrderUseCase = DeleteOrderUseCase(
    orderRepository: orderRepository,
  );
  final getOrdersUseCase = GetOrdersUseCase(
    orderRepository: orderRepository,
  );
  final getOrderByIdUseCase = GetOrderByIdUseCase(
    orderRepository: orderRepository,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit(loginUseCase: loginUsecase)),
        BlocProvider(
          create: (_) => RegisterCubit(registerUseCase: registerUsecase),
        ),
        BlocProvider(
          create: (_) =>
              GetMedicineCubit(getMedicinesUseCase: getMedicinesUsecase),
        ),
        BlocProvider(
          create: (_) => GetMedicineByIdCubit(
            getMedicineByIdUseCase: getMedicineByIdUseCase,
          ),
        ),
        BlocProvider(
          create: (_) => CreateOrderCubit(createOrderUseCase: createOrderUseCase)
        ),
        BlocProvider(
          create: (_) => CancelOrderCubit(deleteOrderUseCase: deleteOrderUseCase)
        ),
        BlocProvider(
          create: (_) => GetMyOrderCubit(getOrdersUseCase: getOrdersUseCase)
        ),
        BlocProvider(
          create: (_) => GetOrderByIdCubit(getOrderByIdUseCase: getOrderByIdUseCase)
        ),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: GetMyOrderScreen(),
    );
  }
}
