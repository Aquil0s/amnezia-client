#ifndef CONNECTIONCONTROLLER_H
#define CONNECTIONCONTROLLER_H

#include "ui/models/servers_model.h"
#include "ui/models/containers_model.h"
#include "protocols/vpnprotocol.h"
#include "vpnconnection.h"

class ConnectionController : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY connectionStateChanged)
    Q_PROPERTY(bool isConnectionInProgress READ isConnectionInProgress NOTIFY connectionStateChanged)
    Q_PROPERTY(QString connectionStateText READ connectionStateText NOTIFY connectionStateChanged)

    explicit ConnectionController(const QSharedPointer<ServersModel> &serversModel,
                                  const QSharedPointer<ContainersModel> &containersModel,
                                  const QSharedPointer<VpnConnection> &vpnConnection,
                                  QObject *parent = nullptr);

    bool isConnected() const;
    bool isConnectionInProgress() const;
    QString connectionStateText() const;

public slots:
    void openConnection();
    void closeConnection();

    QString getLastConnectionError();
    void onConnectionStateChanged(Vpn::ConnectionState state);

signals:
    void connectToVpn(int serverIndex, const ServerCredentials &credentials, DockerContainer container, const QJsonObject &containerConfig);
    void disconnectFromVpn();
    void connectionStateChanged();

    void connectionErrorOccurred(QString errorMessage);

private:
    QSharedPointer<ServersModel> m_serversModel;
    QSharedPointer<ContainersModel> m_containersModel;

    QSharedPointer<VpnConnection> m_vpnConnection;

    bool m_isConnected = false;
    bool m_isConnectionInProgress = false;
    QString m_connectionStateText = tr("Connect");
};

#endif // CONNECTIONCONTROLLER_H