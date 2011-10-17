/****************************************************************************
**
** Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QORGANIZEREVENTTIME_H
#define QORGANIZEREVENTTIME_H

#include <QString>

#include "qorganizerglobal.h"
#include "qorganizeritemdetail.h"
#include "qorganizeritem.h"

QTORGANIZER_BEGIN_NAMESPACE

/* Leaf class */
class Q_ORGANIZER_EXPORT QOrganizerEventTime : public QOrganizerItemDetail
{
public:
#ifdef Q_QDOC
    static const QLatin1Constant DefinitionName;
    static const QLatin1Constant FieldStartDateTime;
    static const QLatin1Constant FieldEndDateTime;
    static const QLatin1Constant FieldAllDay;
#else
    Q_DECLARE_CUSTOM_ORGANIZER_DETAIL(QOrganizerEventTime, "EventTime")
    Q_DECLARE_LATIN1_CONSTANT(FieldStartDateTime, "StartDateTime");
    Q_DECLARE_LATIN1_CONSTANT(FieldEndDateTime, "EndDateTime");
    Q_DECLARE_LATIN1_CONSTANT(FieldAllDay, "AllDay");
#endif

    void setStartDateTime(const QDateTime& startDateTime) {setValue(FieldStartDateTime, startDateTime);}
    QDateTime startDateTime() const {return value<QDateTime>(FieldStartDateTime);}
    void setEndDateTime(const QDateTime& endDateTime) {setValue(FieldEndDateTime, endDateTime);}
    QDateTime endDateTime() const {return value<QDateTime>(FieldEndDateTime);}
    void setAllDay(bool isAllDay) {setValue(FieldAllDay, isAllDay);}
    bool isAllDay() const {return value<bool>(FieldAllDay);}
};

QTORGANIZER_END_NAMESPACE

#endif

