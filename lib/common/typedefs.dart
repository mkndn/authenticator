typedef Supplier<T> = T Function();
typedef Func<T, R> = R Function(T);
typedef BiFunc<X, Y, R> = R Function(X, Y);
typedef Consumer<T> = void Function(T);
typedef FutureCallback = Future<void> Function();
typedef FutureFunc<T, R> = Future<R> Function(T);
typedef BiConsumer<T, U> = void Function(T, U);
typedef JsonMap = Map<String, dynamic>;
