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

#ifndef QVERSITWRITER_P_H
#define QVERSITWRITER_P_H

//
//  W A R N I N G
//  -------------
//
// This file is not part of the Qt API.  It exists purely as an
// implementation detail.  This header file may change from version to
// version without notice, or even be removed.
//
// We mean it.
//

#include <qversitwriter.h>
#include <qversitdocument.h>
#include <qversitproperty.h>

#include <QThread>
#include <QIODevice>
#include <QMutex>
#include <QWaitCondition>

QT_BEGIN_NAMESPACE
class QBuffer;
QT_END_NAMESPACE

QTVERSIT_BEGIN_NAMESPACE

class QVersitDocumentWriter;

class QVersitWriterPrivate : public QThread
{
    Q_OBJECT

signals:
    void stateChanged(QVersitWriter::State state);

public:
    QVersitWriterPrivate();
    virtual ~QVersitWriterPrivate();
    void init(QVersitWriter* writer);
    void write();

    // mutexed getters and setters.
    void setState(QVersitWriter::State);
    QVersitWriter::State state() const;
    void setError(QVersitWriter::Error);
    QVersitWriter::Error error() const;
    void setCanceling(bool cancelling);
    bool isCanceling() const;
    void setDocumentType(QVersitDocument::VersitType type);
    QVersitDocument::VersitType documentType() const;

    void run();

    static QVersitDocumentWriter* writerForType(QVersitDocument::VersitType type, const QVersitDocument& document);

    QIODevice* mIoDevice;
    QScopedPointer<QBuffer> mOutputBytes; // Holds the data set by setData()
    QList<QVersitDocument> mInput;
    QVersitWriter::State mState;
    QVersitWriter::Error mError;
    bool mIsCanceling;
    mutable QMutex mMutex;
    QTextCodec* mDefaultCodec;
    QVersitDocument::VersitType mType;
};

QTVERSIT_END_NAMESPACE

#endif // QVERSITWRITER_P_H
