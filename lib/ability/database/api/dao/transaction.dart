class Transaction {
  Object transaction;

  Transaction(this.transaction);

  static T getOr<T>(Transaction? tx, T defaultTx) {
    if (null == tx) {
      return defaultTx;
    }
    return tx.transaction as T;
  }

  T getTx<T>() => transaction as T;
}
