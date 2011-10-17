/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
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

#ifndef QCONTACTURL_H
#define QCONTACTURL_H

#include <QString>
#include <QUrl>

#include <qcontactsglobal.h>
#include "qcontactdetail.h"
#include "qcontact.h"

QTCONTACTS_BEGIN_NAMESPACE

/* Leaf class */
class Q_CONTACTS_EXPORT QContactUrl : public QContactDetail
{
public:
#ifdef Q_QDOC
    static const QLatin1Constant DefinitionName;
    static const QLatin1Constant FieldUrl;
    static const QLatin1Constant FieldSubType;
    static const QLatin1Constant SubTypeHomePage;
    static const QLatin1Constant SubTypeBlog;
    static const QLatin1Constant SubTypeFavourite;
#else
    Q_DECLARE_CUSTOM_CONTACT_DETAIL(QContactUrl, "Url")
    Q_DECLARE_LATIN1_CONSTANT(FieldUrl, "Url");
    Q_DECLARE_LATIN1_CONSTANT(FieldSubType, "SubType");
    Q_DECLARE_LATIN1_CONSTANT(SubTypeHomePage, "HomePage");
    Q_DECLARE_LATIN1_CONSTANT(SubTypeBlog, "Blog");
    Q_DECLARE_LATIN1_CONSTANT(SubTypeFavourite, "Favourite");
#endif

    void setUrl(const QString& url) {setValue(FieldUrl, url);}
    void setUrl(const QUrl& url) {setValue(FieldUrl, url.toString());}
    QString url() const {return value(FieldUrl);}

    void setSubType(const QString& subType) {setValue(FieldSubType, subType);}
    QString subType() const {return value(FieldSubType);}
};

QTCONTACTS_END_NAMESPACE

#endif

