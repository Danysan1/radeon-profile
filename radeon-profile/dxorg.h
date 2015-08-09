// copyright marazmista @ 29.03.2014

// class for support open source driver for Radeon cards //

#ifndef DXORG_H
#define DXORG_H

#include "globalStuff.h"
#include "daemonComm.h"

#include <QString>
#include <QList>
#include <QTreeWidgetItem>
#include <QSharedMemory>
#include <QThread>

class dXorg
{
public:
    dXorg() {}

    static QString driverName;

    static globalStuff::gpuClocksStruct getClocks(bool forFeatures = false);
    static QString getClocksRawData(bool forFeatures);
    static float getTemperature();
    static QList<QTreeWidgetItem *> getCardConnectors();
    static QStringList getGLXInfo(QString gpuName, QProcessEnvironment env);
    static QList<QTreeWidgetItem *> getModuleInfo();
    static QString getCurrentPowerLevel();
    static QString getCurrentPowerProfile();
    static int getPwmSpeed();

    static void setPowerProfile(globalStuff::powerProfiles _newPowerProfile);
    static void setForcePowerLevel(globalStuff::forcePowerLevels);
    static void setPwmManuaControl(bool manual);
    static void setPwmValue(int value);

    static QStringList detectCards();
    static void figureOutGpuDataFilePaths(QString gpuName);
    static void configure(QString gpuName);
    static globalStuff::driverFeatures figureOutDriverFeatures();
    static void reconfigureDaemon();
    static bool daemonConnected();
    static globalStuff::gpuClocksStruct getFeaturesFallback();


private:
    enum tempSensor {
        SYSFS_HWMON = 0, // try to read temp from /sys/class/hwmonX/device/tempX_input
        CARD_HWMON, // try to read temp from /sys/class/drm/cardX/device/hwmon/hwmonX/temp1_input
        PCI_SENSOR,  // PCI Card, 'radeon-pci' label on sensors output
        MB_SENSOR,  // Card in motherboard, 'VGA' label on sensors output
        TS_UNKNOWN
    };

    static QChar gpuSysIndex;
    static QSharedMemory sharedMem;

    static struct driverFilePaths {
    QString powerMethodFilePath, profilePath, dpmStateFilePath ,
            clocksPath , forcePowerLevelFilePath , sysfsHwmonTempPath, moduleParamsPath, pwmEnablePath, pwmSpeedPath, pwmMaxSpeedPath;
    } filePaths;
    static int sensorsGPUtempIndex;
    static dXorg::tempSensor currentTempSensor;
    static globalStuff::powerMethod currentPowerMethod;

    static QString findSysfsHwmonForGPU();
    static globalStuff::powerMethod getPowerMethod();
    static tempSensor testSensor();
    static void setNewValue(const QString &filePath, const QString &newValue);
    static QString findSysFsHwmonForGpu();
};

#endif // DXORG_H
