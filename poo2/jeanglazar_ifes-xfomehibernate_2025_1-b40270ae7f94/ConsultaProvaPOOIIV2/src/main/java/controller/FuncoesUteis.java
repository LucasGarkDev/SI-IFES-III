package controller;



import domain.Endereco;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.imageio.ImageIO;
import javax.imageio.stream.ImageOutputStream;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import org.json.JSONObject;


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author jean_
 */
public class FuncoesUteis {
    
    public static String dateToStr (Date data) {
        DateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        formato.setLenient(false);
        return formato.format(data);        
    }
    
    public static Date strToDate (String strData) throws ParseException {
        DateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        formato.setLenient(false);
        return formato.parse(strData);
    }
    
    
    public static void mostrarFoto(JLabel lbl, Icon ic) {
        
        // Redimensionar
        ImageIcon imagem = (ImageIcon) ic;
        imagem.setImage(imagem.getImage().getScaledInstance(lbl.getWidth(), lbl.getHeight(), Image.SCALE_DEFAULT));
        
        lbl.setText("");                
        lbl.setIcon(imagem);
    } 

    public static Endereco consultarCEP(String cep) throws MalformedURLException, IOException  {

        Endereco ender = null;
        
        // Definir a URL do serviço ViaCEP
        URL url = new URL("https://viacep.com.br/ws/" + cep + "/json/");

        // Definir a URL do serviço GOV.BR
        //URL url = new URL("https://h-apigateway.conectagov.estaleiro.serpro.gov.br/api-cep/v1/consulta/cep/" + cep);

        // Abrir conexão HTTP
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        // Ler a resposta
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }

        // Converter a resposta JSON em um objeto JSONObject
        JSONObject jsonObject = new JSONObject(response.toString());

        // Exibir as informações do endereço
        if (!jsonObject.has("erro")) {                            

            ender = new Endereco();
            ender.setLogradouro(jsonObject.getString("logradouro"));
            ender.setBairro(jsonObject.getString("bairro") );
            ender.setCidade(jsonObject.getString("localidade") );
            ender.setUf(jsonObject.getString("uf") );

        } else {
            System.out.println("CEP não encontrado.");
               
        }

        // Fechar conexão
        connection.disconnect();
        return ender;

    }    
    
    public static byte[] IconToBytes(Icon icon) {
        if (icon == null) {
            return null;
        }
        BufferedImage img = new BufferedImage(icon.getIconWidth(), icon.getIconHeight(), BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = img.createGraphics();
        icon.paintIcon(null, g2d, 0, 0);
        g2d.dispose();

        byte[] bFile = null;
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            ImageOutputStream ios = ImageIO.createImageOutputStream(baos);
            try {
                ImageIO.write(img, "png", ios);
                // Set a flag to indicate that the write was successful
            } finally {
                ios.close();
            }
            bFile = baos.toByteArray();
        } catch (IOException ex) {
            bFile = null;
            System.out.println(ex);
        } finally {
            return bFile;
        }

    }

    
    public static boolean isCPF(String parCpf) {      
       
        // TESTE
        return true;
/*        
        // considera-se erro cpf's formados por uma sequencia de numeros iguais
        String cpf;
        cpf = parCpf.replace(".", "");
        cpf = cpf.replace(".", "");
        cpf = cpf.replace("-", "");
        
        if (cpf.equals("00000000000")
                || cpf.equals("11111111111")
                || cpf.equals("22222222222") || cpf.equals("33333333333")
                || cpf.equals("44444444444") || cpf.equals("55555555555")
                || cpf.equals("66666666666") || cpf.equals("77777777777")
                || cpf.equals("88888888888") || cpf.equals("99999999999")
                || (cpf.length() != 11)) {
            //return (false);
            
            // TESTE
            return true;
        }

        char dig10, dig11;
        int sm, i, r, num, peso;

        // Calculo do 1o. Digito Verificador
        sm = 0;
        peso = 10;
        for (i = 0; i < 9; i++) {
            // converte o i-esimo caractere do cpf em um numero:
            // por exemplo, transforma o caractere '0' no inteiro 0         
            // (48 eh a posicao de '0' na tabela ASCII)         
            num = (int) (cpf.charAt(i) - 48);
            sm = sm + (num * peso);
            peso = peso - 1;
        }

        r = 11 - (sm % 11);
        if ((r == 10) || (r == 11)) {
            dig10 = '0';
        } else {
            dig10 = (char) (r + 48); // converte no respectivo caractere numerico
        }
        // Calculo do 2o. Digito Verificador
        sm = 0;
        peso = 11;
        for (i = 0; i < 10; i++) {
            num = (int) (cpf.charAt(i) - 48);
            sm = sm + (num * peso);
            peso = peso - 1;
        }

        r = 11 - (sm % 11);
        if ((r == 10) || (r == 11)) {
            dig11 = '0';
        } else {
            dig11 = (char) (r + 48);
        }

        // Verifica se os digitos calculados conferem com os digitos informados.
        if ((dig10 == cpf.charAt(9)) && (dig11 == cpf.charAt(10))) {
            return (true);
        } else {
            return (false);
        }
        */
    }

}
