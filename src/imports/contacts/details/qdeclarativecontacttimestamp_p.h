/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtContacts module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or (at your option) the GNU General
** Public license version 3 or any later version approved by the KDE Free
** Qt Foundation. The licenses are as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-2.0.html and
** https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QDECLARATIVECONTACTTIMESTAMP_H
#define QDECLARATIVECONTACTTIMESTAMP_H

#include <QtContacts/qcontacttimestamp.h>

#include "qdeclarativecontactdetail_p.h"

QTCONTACTS_USE_NAMESPACE

QT_BEGIN_NAMESPACE

class QDeclarativeContactTimestamp : public QDeclarativeContactDetail
{
    Q_OBJECT
    Q_PROPERTY(QDateTime lastModified READ lastModified WRITE setLastModified NOTIFY valueChanged)
    Q_PROPERTY(QDateTime created READ created WRITE setCreated NOTIFY valueChanged)
    Q_ENUMS(FieldType)
    Q_CLASSINFO("DefaultProperty", "lastModified")
public:
    enum FieldType {
        LastModified = QContactTimestamp::FieldModificationTimestamp,
        Created = QContactTimestamp::FieldCreationTimestamp
    };

    DetailType detailType() const
    {
        return QDeclarativeContactDetail::Timestamp;
    }

    QDeclarativeContactTimestamp(QObject* parent = nullptr)
        :QDeclarativeContactDetail(parent)
    {
        setDetail(QContactTimestamp());
        connect(this, SIGNAL(valueChanged()), SIGNAL(detailChanged()));
    }
    void setLastModified(const QDateTime& v)
    {
        if (!readOnly() && v != lastModified()) {
            detail().setValue(QContactTimestamp::FieldModificationTimestamp, v);
            emit valueChanged();
        }
    }
    QDateTime lastModified() const {return detail().value<QDateTime>(QContactTimestamp::FieldModificationTimestamp);}
    void setCreated(const QDateTime& v)
    {
        if (!readOnly() && v != created()) {
            detail().setValue(QContactTimestamp::FieldCreationTimestamp, v);
            emit valueChanged();
        }
    }
    QDateTime created() const {return detail().value<QDateTime>(QContactTimestamp::FieldCreationTimestamp);}
signals:
    void valueChanged();
};

QT_END_NAMESPACE

QML_DECLARE_TYPE(QDeclarativeContactTimestamp)

#endif // QDECLARATIVECONTACTTIMESTAMP_H
