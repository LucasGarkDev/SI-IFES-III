package controller;



import domain.Endereco;
import java.awt.Image;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
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

}
