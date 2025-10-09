/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package common;
import java.io.*;
/**
 *
 * @author lucas
 */
public class Bytes {
    public static byte[] toBytes(Serializable obj) throws IOException {
        try (ByteArrayOutputStream bos = new ByteArrayOutputStream();
             ObjectOutputStream out = new ObjectOutputStream(bos)) {
            out.writeObject(obj);
            return bos.toByteArray();
        }
    }

    public static Object fromBytes(byte[] data, int length)
            throws IOException, ClassNotFoundException {
        try (ByteArrayInputStream bis = new ByteArrayInputStream(data, 0, length);
             ObjectInputStream in = new ObjectInputStream(bis)) {
            return in.readObject();
        }
    }
}
