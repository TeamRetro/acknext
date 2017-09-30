#ifndef ACKGIMP_GLOBAL_HPP
#define ACKGIMP_GLOBAL_HPP

#include <QtCore/qglobal.h>

#if defined(ACKGIMP_LIBRARY)
#  define ACKGIMPSHARED_EXPORT Q_DECL_EXPORT
#else
#  define ACKGIMPSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // ACKGIMP_GLOBAL_HPP