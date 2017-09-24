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

#ifndef QDECLARATIVECONTACTDETAILRANGEFILTER_H
#define QDECLARATIVECONTACTDETAILRANGEFILTER_H

#include <QtContacts/qcontactdetailrangefilter.h>

#include "qdeclarativecontact_p.h"
#include "qdeclarativecontactfilter_p.h"

QTCONTACTS_USE_NAMESPACE

QT_BEGIN_NAMESPACE

class QDeclarativeContactDetailRangeFilter : public QDeclarativeContactFilter
{
    Q_OBJECT
    Q_PROPERTY(QDeclarativeContactDetail::DetailType detail READ detail WRITE setDetail NOTIFY valueChanged)
    Q_PROPERTY(int field READ field WRITE setField NOTIFY valueChanged)
    Q_PROPERTY(QVariant min READ minValue WRITE setMinValue NOTIFY valueChanged)
    Q_PROPERTY(QVariant max READ maxValue WRITE setMaxValue NOTIFY valueChanged)
    Q_PROPERTY(MatchFlags matchFlags READ matchFlags WRITE setMatchFlags NOTIFY valueChanged)
    Q_PROPERTY(RangeFlags rangeFlags READ rangeFlags WRITE setRangeFlags NOTIFY valueChanged)
    Q_FLAGS(RangeFlags)
public:
    enum RangeFlag {
        IncludeLower = QContactDetailRangeFilter::IncludeLower,
        IncludeUpper = QContactDetailRangeFilter::IncludeUpper,
        ExcludeLower = QContactDetailRangeFilter::ExcludeLower,
        ExcludeUpper = QContactDetailRangeFilter::ExcludeUpper
    };
    Q_DECLARE_FLAGS(RangeFlags, RangeFlag)

    QDeclarativeContactDetailRangeFilter(QObject* parent = nullptr)
        : QDeclarativeContactFilter(parent)
    {
        connect(this, SIGNAL(valueChanged()), SIGNAL(filterChanged()));
    }

    void setDetail(QDeclarativeContactDetail::DetailType detail)
    {
        if (detail != static_cast<QDeclarativeContactDetail::DetailType>(d.detailType())) {
            d.setDetailType(static_cast<QContactDetail::DetailType>(detail), d.detailField());
            emit valueChanged();
        }
    }

    QDeclarativeContactDetail::DetailType detail() const
    {
        return static_cast<QDeclarativeContactDetail::DetailType>(d.detailType());
    }

    void setField(int field)
    {
        if (field != d.detailField()) {
            d.setDetailType(d.detailType(), field);
            emit valueChanged();
        }
    }

    int field() const
    {
        return d.detailField();
    }

    QDeclarativeContactFilter::MatchFlags matchFlags() const
    {
        QDeclarativeContactFilter::MatchFlags flags;
        flags = ~flags & (int)d.matchFlags();
        return flags;
    }
    void setMatchFlags(QDeclarativeContactFilter::MatchFlags flags)
    {
        QContactFilter::MatchFlags newFlags;
        newFlags = ~newFlags & (int)flags;
        if (newFlags != d.matchFlags()) {
            d.setMatchFlags(newFlags);
            emit valueChanged();
        }
    }

    QDeclarativeContactDetailRangeFilter::RangeFlags rangeFlags() const
    {
        QDeclarativeContactDetailRangeFilter::RangeFlags flags;
        flags = ~flags & (int)d.rangeFlags();
        return flags;
    }
    void setRangeFlags(QDeclarativeContactDetailRangeFilter::RangeFlags flags)
    {
        QContactDetailRangeFilter::RangeFlags newFlags;
        newFlags = ~newFlags & (int)flags;
        if (newFlags != d.rangeFlags()) {
            d.setRange(d.minValue(), d.maxValue(), newFlags);
            emit valueChanged();
        }
    }

    QVariant minValue() const
    {
        return d.minValue();
    }
    void setMinValue(const QVariant& value)
    {
        if (value != d.minValue()) {
            d.setRange(value, d.maxValue(), d.rangeFlags());
            emit valueChanged();
        }
    }

    QVariant maxValue() const
    {
        return d.maxValue();
    }
    void setMaxValue(const QVariant& value)
    {
        if (value != d.maxValue()) {
            d.setRange(d.minValue(), value, d.rangeFlags());
            emit valueChanged();
        }
    }

    QContactFilter filter() const
    {
        return d;
    }
signals:
    void valueChanged();


private:
    QContactDetailRangeFilter d;
};

QT_END_NAMESPACE

QML_DECLARE_TYPE(QDeclarativeContactDetailRangeFilter)

#endif // QDECLARATIVECONTACTDETAILRANGEFILTER_H
