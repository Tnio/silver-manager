package com.silverfox.finance.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.ftp.FTPClient;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class FtpUtil {
	private static final Log log = LogFactory.getLog(FtpUtil.class);
	private static FTPClient ftpClient;
	private static ChannelSftp sftp;
	private static final String SFTP = "sftp";
	private static final String FTP = "ftp";

	public static boolean downLoadFromFtp(String ftpIp, String userName, String password, int timeout, int prot,
			String encoding, String ftpPath, String ftpType, String loadFile, String ftpFile) {
		if (checkLocal(loadFile, ftpFile)) {
			if (ftpType.equals(FTP)) {
				if (openFtp(ftpIp, userName, password, timeout, prot, encoding)) {
					ftpClient.enterLocalPassiveMode();
					try {
						ftpClient.setFileTransferMode(org.apache.commons.net.ftp.FTP.STREAM_TRANSFER_MODE);
						ftpClient.setFileType(org.apache.commons.net.ftp.FTP.BINARY_FILE_TYPE);
						boolean result = ftpClient.changeWorkingDirectory(ftpPath);
						if (result) {
							return readAndWriteFile(loadFile, ftpFile, ftpType);
						} else {
							log.info("Called " + ftpPath + " directory on the FTP server does not exist");
						}
					} catch (IOException e) {
						log.info(e.getMessage());
					}
				} else {
					log.info("open the FTP server failure");
					return false;
				}
			} else if (ftpType.equals(SFTP)) {
				if (openSftp(ftpIp, userName, password, timeout, prot, encoding)) {
					try {
						sftp.cd(ftpPath);
						return readAndWriteFile(loadFile, ftpFile, ftpType);
					} catch (SftpException e) {
						log.info("Called " + ftpPath + " directory on the SFTP server does not exist");
						return false;
					}
				}
			} else {
				// do nothing
			}
		} else {
			return true;
		}
		return false;
	}

	public static boolean openFtp(String ftpIp, String username, String password, int timeout, int port,
			String encoding) {
		ftpClient = new FTPClient();
		try {
			ftpClient.setDataTimeout(timeout);
			ftpClient.setControlEncoding(encoding);
			ftpClient.setDefaultTimeout(timeout);
			ftpClient.connect(ftpIp, port);
			boolean b = ftpClient.login(username, password);
			if (b) {
				log.info("Login FTP server " + ftpIp + " success !");
				return b;
			} else {
				log.info("Login FTP server" + ftpIp + " failure");
				return b;
			}
		} catch (IOException e) {
			log.info("Login FTP server " + ftpIp + "failure,Unable to open the FTP server...");
			return false;
		}
	}

	public static boolean openSftp(String ftpIp, String username, String password, int timeout, int port,
			String encoding) {
		JSch jsch = new JSch();
		Session session;
		Channel channel;
		try {
			session = jsch.getSession(username, ftpIp, port);
			Properties sshConfig = new Properties();
			sshConfig.put("StrictHostKeyChecking", "no");
			session.setConfig(sshConfig);
			session.setPassword(password);
			session.connect(20000);
			channel = session.openChannel(SFTP);
			channel.connect();
			sftp = (ChannelSftp) channel;
			return true;
		} catch (JSchException e) {
			log.info("Login SFTP server " + ftpIp + " failure,Unable to open the SFTP server...");
			if (sftp != null && sftp.isConnected()) {
				sftp.disconnect();
			}
			return false;
		}
	}

	public static boolean readAndWriteFile(String loadFile, String ftpFile, String ftpType) {
		File outFile = new File(loadFile + File.separator + ftpFile);
		try {
			String line = null;
			InputStreamReader isr = null;
			if (ftpType.equals(SFTP)) {
				isr = new InputStreamReader(sftp.get(ftpFile), "UTF-8");
			} else {
				isr = new InputStreamReader(ftpClient.retrieveFileStream(ftpFile), "UTF-8");
			}

			BufferedReader br = new BufferedReader(isr);
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "UTF-8"));
			while ((line = br.readLine()) != null) {
				bw.write(line);
				bw.newLine();
			}
			bw.flush();
			try {
				if (isr != null)
					isr.close();
				if (bw != null)
					bw.close();
				if (br != null)
					br.close();
			} catch (IOException e) {
				log.info(e.getMessage());
			}

			if (sftp != null && sftp.isConnected()) {
				sftp.disconnect();
			}
			return true;
		} catch (Exception e) {
			log.info("DownLoad " + ftpFile + " on the SFTP server failure");
			return false;
		}
	}

	public static boolean checkLocal(String loadFile, String ftpFile) {
		File file = new File(loadFile + File.separator + ftpFile);
		if (file.exists() && file.isFile()) {
			log.info("Local file already exists, do not need to download again");
			return false;
		}
		return true;
	}
}