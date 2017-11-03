//
// Common
//

enum LockMode { "shared", "exclusive" };

dictionary LockOptions {
  LockMode mode = "exclusive";
  boolean ifAvailable = false;
  AbortSignal signal;
};

// ======================================================================
// Proposal 1 - Auto-Release with waitUntil()
//


partial interface WindowOrWorkerGlobalScope {
  [SecureContext]
  Promise<Lock> requestLock((DOMString or sequence<DOMString>) scope,
                            optional LockOptions options);
};

[SecureContext, Exposed=(Window,Worker)]
interface Lock {
  readonly attribute FrozenArray<DOMString> scope;
  readonly attribute LockMode mode;
  readonly attribute Promise<void> released;

  void waitUntil(Promise<any> p);
};

// ======================================================================
// Proposal 2 - Explicit Release
//

partial interface WindowOrWorkerGlobalScope {
  [SecureContext]
  Promise<Lock> requestLock((DOMString or sequence<DOMString>) scope,
                            optional LockOptions options);
};

[SecureContext, Exposed=(Window,Worker)]
interface Lock {
  readonly attribute FrozenArray<DOMString> scope;
  readonly attribute LockMode mode;
  readonly attribute Promise<void> released;

  void release();
};

// ======================================================================
// Proposal 3 - Scoped Release
//

callback LockRequestCallback = Promise<any> (Lock lock);

partial interface WindowOrWorkerGlobalScope {
  [SecureContext]
  Promise<any> requestLock((DOMString or sequence<DOMString>) scope,
                           LockRequestCallback callback,
                           optional LockOptions options);
};

[SecureContext, Exposed=(Window,Worker)]
interface Lock {
  readonly attribute FrozenArray<DOMString> scope;
  readonly attribute LockMode mode;
  readonly attribute Promise<void> released;
};
