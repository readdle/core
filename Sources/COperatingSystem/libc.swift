#if os(Linux) || os(Android)
	@_exported import Glibc
#else
	@_exported import Darwin.C
#endif
