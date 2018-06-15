/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.logging.Logger;
import org.springframework.stereotype.Service;

/**
 *
 * @author Lenita
 */
@Service
public class FileUploadService {

    private static final Logger LOGGER = Logger.getLogger(FileUploadService.class.getName());

//    private static final String SAVE_PATH = "C:\\Users\\Lenita\\Documents\\Documentos_ESECO\\";
    private static final String SAVE_PATH = "/var/www/eseco/documents/";

    public static String upload(String folderName, String fileName, byte[] bytes) throws Exception {

        File diretorio = new File(SAVE_PATH + folderName);
        if (!diretorio.exists()) {
            diretorio.mkdir();
        }

        Path path = Paths.get(SAVE_PATH + folderName + File.separator + fileName);
        Files.write(path, bytes);
        return path.toString();

    }

    public static String getSAVE_PATH() {
        return SAVE_PATH;
    }

}
