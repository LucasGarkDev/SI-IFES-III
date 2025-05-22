/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import domain.Cliente;
import java.awt.Frame;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.List;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JOptionPane;
import org.hibernate.HibernateException;
import viewer.DlgCadCliente;
import viewer.DlgCadPedido;
import viewer.DlgFerramentas;
import viewer.DlgPesqCliente;
import viewer.FrmPrincipal;

/**
 *
 * @author 1547816
 */
public class GerInterGrafica {
    
    private FrmPrincipal janPrincipal = null;
    private DlgCadCliente janCadCliente = null;
    private DlgCadPedido janCadPedido = null;
    private DlgFerramentas janFer = null;
    private DlgPesqCliente janPesqCli = null;
       
    
    private GerenciadorDominio gerDominio;
    
    // ########  SINGLETON  #########
    private static final GerInterGrafica myInstance = new GerInterGrafica();
        
    private GerInterGrafica() {        
        try {
            gerDominio = new GerenciadorDominio();
        } catch (java.lang.ExceptionInInitializerError | HibernateException ex) {
            JOptionPane.showMessageDialog(null, ex, "Erro ao inicializar.", JOptionPane.ERROR_MESSAGE);
            System.exit(0);
        }
    }

    public static GerInterGrafica getMyInstance() {
        return myInstance;
    }
    
    // ######### SINGLETON ###########
   
    // ABRIR JDIALOG
    private JDialog abrirJanela(java.awt.Frame parent, JDialog dlg, Class classe) {
        if (dlg == null){     
            try {
                dlg = (JDialog) classe.getConstructor(Frame.class, boolean.class).newInstance(parent,true);                                
            } catch (NoSuchMethodException | SecurityException | InstantiationException | IllegalAccessException | IllegalArgumentException | InvocationTargetException ex) {
                JOptionPane.showMessageDialog(parent, "Erro ao abrir a janela " + classe.getName() + ". " + ex.getMessage() );
            } 
        }               
        dlg.setVisible(true); 
        return dlg;
    }    

    public GerenciadorDominio getGerDominio() {
        return gerDominio;
    }

    
    
    public void abrirPrincipal() {
        janPrincipal = new FrmPrincipal();
        janPrincipal.setVisible(true);                
    }
    
    public void abrirCadCliente() {
        janCadCliente = (DlgCadCliente) abrirJanela(janPrincipal, janCadCliente,  DlgCadCliente.class ); 
    }
    
    public void abrirCadPedido() {
        janCadPedido = (DlgCadPedido) abrirJanela(janPrincipal, janCadPedido,  DlgCadPedido.class ); 
    }
    
    public void abrirFerramentas() {
        janFer = (DlgFerramentas) abrirJanela(janPrincipal, janFer,  DlgFerramentas.class ); 
    }
    
    public Cliente abrirPesqCliente() {
        janPesqCli = (DlgPesqCliente) abrirJanela(janPrincipal, janPesqCli,  DlgPesqCliente.class ); 
        return janPesqCli.getCliente();
    }

    public void sair() {
        System.exit(0);
    }
            
    public void carregarCombo(JComboBox combo, Class classe) {
        try {
            List lista = gerDominio.listar(classe);                
            combo.setModel(  new DefaultComboBoxModel( lista.toArray() )   );
        } catch (HibernateException ex) {
            JOptionPane.showMessageDialog(janCadCliente, ex, "Cadastro de Cliente", JOptionPane.ERROR_MESSAGE );
        }
    }
    
    

  /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Windows".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(FrmPrincipal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        
        //</editor-fold>
        //</editor-fold>

        
        // TRADUÇÃO
        javax.swing.UIManager.put("OptionPane.yesButtonText", "Sim"); 
        javax.swing.UIManager.put("OptionPane.noButtonText", "Não");
        javax.swing.UIManager.put("OptionPane.cancelButtonText", "Cancelar");
        
        
        /* Create and display the form */
        
        GerInterGrafica gerIG = GerInterGrafica.getMyInstance();
        gerIG.abrirPrincipal();
        
        
    }
    
}

