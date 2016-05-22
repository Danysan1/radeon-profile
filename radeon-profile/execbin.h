
// copyright marazmista @ 29.11.2014

// class for handling executed process from exec page and all stuff
// regarding this process

#ifndef EXECBIN_H
#define EXECBIN_H

#include <QProcess>
#include <QPushButton>
#include <QPlainTextEdit>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QWidget>
#include <QString>
#include <QLabel>

class execBin : public QProcess {
    Q_OBJECT
public:
    execBin();
    ~execBin() {
        delete output;
        delete cmd;
        delete mainLay;
        delete btnLay;
        delete btnSave;
        delete lStatus;
        delete tab;
    }

    void setupTab();
    void runBin(const QString &cmd);
    void appendToLog(const QString &data);
    void setLogFilename(const QString &name);

    QString name;
    QWidget *tab;
    bool logEnabled = false;

private slots:
    void execProcessReadOutput();
    void execProcesStart();
    void execProcesFinished();
    void saveToFile();

private:
    QPlainTextEdit *output;
    QPlainTextEdit *cmd;
    QVBoxLayout *mainLay;
    QHBoxLayout *btnLay;
    QLabel *lStatus;
    QPushButton *btnSave;

    struct {
        QString logFilename, launchTime;
        QStringList log;
    } logData;
};

#endif // EXECBIN_H
