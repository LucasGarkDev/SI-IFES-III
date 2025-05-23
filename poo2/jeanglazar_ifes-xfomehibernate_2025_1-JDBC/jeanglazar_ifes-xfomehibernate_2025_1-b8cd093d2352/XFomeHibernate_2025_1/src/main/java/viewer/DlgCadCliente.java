package viewer;


import controller.FuncoesUteis;
import controller.GerInterGrafica;
import domain.Cidade;
import domain.Cliente;
import domain.Endereco;
import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.filechooser.FileNameExtensionFilter;




/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author 1547816
 */
public class DlgCadCliente extends javax.swing.JDialog {
    
    private File arquivo;
    private Cliente cliSelecionado = null;
    
    public DlgCadCliente(java.awt.Frame parent, boolean modal ) {
        initComponents();   
        
        arquivo = null;
        habilitarBotoes();

    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        grpSexo = new javax.swing.ButtonGroup();
        grpTeste = new javax.swing.ButtonGroup();
        jFileChooser1 = new javax.swing.JFileChooser();
        jPanel5 = new javax.swing.JPanel();
        lblNum = new javax.swing.JLabel();
        lblNome = new javax.swing.JLabel();
        txtNum = new javax.swing.JTextField();
        txtCelular = new javax.swing.JTextField();
        lblEnder = new javax.swing.JLabel();
        lblTelFixo = new javax.swing.JLabel();
        txtTel = new javax.swing.JTextField();
        cmbCidade = new javax.swing.JComboBox();
        lblComplem = new javax.swing.JLabel();
        txtEnder = new javax.swing.JTextField();
        lblEnder7 = new javax.swing.JLabel();
        lblEnder5 = new javax.swing.JLabel();
        txtEmail = new javax.swing.JTextField();
        lblEnder6 = new javax.swing.JLabel();
        txtRef = new javax.swing.JTextField();
        txtBairro = new javax.swing.JTextField();
        lblCidade = new javax.swing.JLabel();
        lblEnder1 = new javax.swing.JLabel();
        txtComplemento = new javax.swing.JTextField();
        txtNome = new javax.swing.JTextField();
        btnNovo = new javax.swing.JButton();
        btnCancelar = new javax.swing.JButton();
        btnPesquisar = new javax.swing.JButton();
        lblCpf = new javax.swing.JLabel();
        lblDtNasc = new javax.swing.JLabel();
        txtCpf = new javax.swing.JFormattedTextField();
        lblCEP = new javax.swing.JLabel();
        txtCEP = new javax.swing.JFormattedTextField();
        btnAlterar = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        rdbFemin = new javax.swing.JRadioButton();
        rdbMasc = new javax.swing.JRadioButton();
        jToggleButton1 = new javax.swing.JToggleButton();
        lblFoto = new javax.swing.JLabel();
        dtNasc = new com.toedter.calendar.JDateChooser();

        setTitle("Cadastro de Cliente");
        setModal(true);
        setResizable(false);
        addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentShown(java.awt.event.ComponentEvent evt) {
                formComponentShown(evt);
            }
        });
        getContentPane().setLayout(new javax.swing.BoxLayout(getContentPane(), javax.swing.BoxLayout.PAGE_AXIS));

        jPanel5.setBorder(javax.swing.BorderFactory.createTitledBorder("Cadastro de Cliente"));

        lblNum.setText("Nº");

        lblNome.setText("Nome");

        lblEnder.setText("Endereço");

        lblTelFixo.setText("Tel. Fixo");

        lblComplem.setText("Complemento");

        lblEnder7.setText("E-mail");

        lblEnder5.setText("Tel. Cel.");

        lblEnder6.setText("Referência");

        lblCidade.setText("Cidade");

        lblEnder1.setText("Bairro");

        btnNovo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/add.png"))); // NOI18N
        btnNovo.setMnemonic('N');
        btnNovo.setText("Novo");
        btnNovo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnNovoActionPerformed(evt);
            }
        });

        btnCancelar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/remove.png"))); // NOI18N
        btnCancelar.setText("Cancelar");
        btnCancelar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCancelarActionPerformed(evt);
            }
        });

        btnPesquisar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/png/16x16/search.png"))); // NOI18N
        btnPesquisar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnPesquisarActionPerformed(evt);
            }
        });

        lblCpf.setText("CPF");

        lblDtNasc.setText("Dt. Nasc.");

        try {
            txtCpf.setFormatterFactory(new javax.swing.text.DefaultFormatterFactory(new javax.swing.text.MaskFormatter("###.###.###-##")));
        } catch (java.text.ParseException ex) {
            ex.printStackTrace();
        }

        lblCEP.setText("CEP");

        try {
            txtCEP.setFormatterFactory(new javax.swing.text.DefaultFormatterFactory(new javax.swing.text.MaskFormatter("#####-###")));
        } catch (java.text.ParseException ex) {
            ex.printStackTrace();
        }
        txtCEP.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txtCEPFocusLost(evt);
            }
        });

        btnAlterar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/repeat.png"))); // NOI18N
        btnAlterar.setMnemonic('A');
        btnAlterar.setText("Alterar");
        btnAlterar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnNovoActionPerformed(evt);
            }
        });

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder("Sexo"));
        jPanel2.setLayout(new java.awt.BorderLayout());

        grpSexo.add(rdbFemin);
        rdbFemin.setMnemonic('F');
        rdbFemin.setText("Feminino");
        rdbFemin.setActionCommand("Feminino");
        rdbFemin.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/rb.gif"))); // NOI18N
        rdbFemin.setRolloverIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/rbr.gif"))); // NOI18N
        rdbFemin.setSelectedIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/rbrs.gif"))); // NOI18N
        jPanel2.add(rdbFemin, java.awt.BorderLayout.CENTER);

        grpSexo.add(rdbMasc);
        rdbMasc.setMnemonic('M');
        rdbMasc.setSelected(true);
        rdbMasc.setText("Masculino");
        rdbMasc.setActionCommand("Masculino");
        rdbMasc.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/rb.gif"))); // NOI18N
        rdbMasc.setRolloverIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/rbp.gif"))); // NOI18N
        rdbMasc.setSelectedIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/rbs.gif"))); // NOI18N
        jPanel2.add(rdbMasc, java.awt.BorderLayout.PAGE_START);

        jToggleButton1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/png/16x16/rss.png"))); // NOI18N
        jToggleButton1.setSelectedIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/png/16x16/rss_remove.png"))); // NOI18N

        lblFoto.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblFoto.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/png/48x48/user.png"))); // NOI18N
        lblFoto.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        lblFoto.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                lblFotoMouseClicked(evt);
            }
        });

        dtNasc.setDateFormatString("dd/MM/yyyy");

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel5Layout.createSequentialGroup()
                .addGap(14, 14, 14)
                .addComponent(btnAlterar)
                .addGap(18, 18, 18)
                .addComponent(btnNovo, javax.swing.GroupLayout.PREFERRED_SIZE, 85, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(btnCancelar)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jToggleButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblTelFixo)
                            .addComponent(lblEnder7))
                        .addGap(18, 18, 18)
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel5Layout.createSequentialGroup()
                                .addComponent(txtTel, javax.swing.GroupLayout.PREFERRED_SIZE, 78, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(13, 13, 13)
                                .addComponent(lblEnder5)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(txtCelular))
                            .addComponent(txtEmail)))
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel5Layout.createSequentialGroup()
                                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(lblEnder)
                                    .addComponent(lblCpf)
                                    .addComponent(lblNum)
                                    .addComponent(lblEnder1)
                                    .addComponent(lblEnder6)
                                    .addComponent(lblCidade))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(cmbCidade, javax.swing.GroupLayout.PREFERRED_SIZE, 117, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                                        .addComponent(txtBairro, javax.swing.GroupLayout.Alignment.LEADING)
                                        .addComponent(txtNum, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 46, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addGroup(jPanel5Layout.createSequentialGroup()
                                            .addComponent(lblComplem)
                                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                            .addComponent(txtComplemento, javax.swing.GroupLayout.PREFERRED_SIZE, 92, javax.swing.GroupLayout.PREFERRED_SIZE))
                                        .addComponent(txtEnder, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 280, Short.MAX_VALUE)
                                        .addComponent(txtRef, javax.swing.GroupLayout.Alignment.LEADING))))
                            .addGroup(jPanel5Layout.createSequentialGroup()
                                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addGroup(jPanel5Layout.createSequentialGroup()
                                        .addGap(223, 223, 223)
                                        .addComponent(btnPesquisar, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                                    .addGroup(jPanel5Layout.createSequentialGroup()
                                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                            .addComponent(lblNome)
                                            .addComponent(lblDtNasc)
                                            .addComponent(lblCEP))
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                            .addComponent(txtNome, javax.swing.GroupLayout.PREFERRED_SIZE, 163, javax.swing.GroupLayout.PREFERRED_SIZE)
                                            .addGroup(jPanel5Layout.createSequentialGroup()
                                                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                                    .addComponent(txtCpf)
                                                    .addComponent(txtCEP)
                                                    .addComponent(dtNasc, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE))
                                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(lblFoto, javax.swing.GroupLayout.PREFERRED_SIZE, 88, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGap(92, 92, 92)
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblCEP)
                            .addComponent(txtCEP, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel5Layout.createSequentialGroup()
                                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                        .addComponent(lblNome)
                                        .addComponent(txtNome, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                                    .addComponent(btnPesquisar, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(jPanel5Layout.createSequentialGroup()
                                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                            .addComponent(lblCpf)
                                            .addComponent(txtCpf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                            .addComponent(lblDtNasc)
                                            .addComponent(dtNasc, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                                    .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                            .addComponent(lblFoto, javax.swing.GroupLayout.PREFERRED_SIZE, 94, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(lblEnder)
                    .addComponent(txtEnder, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(7, 7, 7)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblNum)
                    .addComponent(txtNum, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtComplemento, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblComplem))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblEnder1)
                    .addComponent(txtBairro, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblEnder6)
                    .addComponent(txtRef, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblCidade)
                    .addComponent(cmbCidade, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel5Layout.createSequentialGroup()
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblTelFixo)
                            .addComponent(txtTel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtCelular, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblEnder5))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblEnder7)
                            .addComponent(txtEmail, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(12, 12, 12)
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(btnNovo)
                            .addComponent(btnCancelar)
                            .addComponent(btnAlterar)))
                    .addComponent(jToggleButton1, javax.swing.GroupLayout.Alignment.TRAILING))
                .addContainerGap(14, Short.MAX_VALUE))
        );

        getContentPane().add(jPanel5);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnNovoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnNovoActionPerformed

        String nome = txtNome.getText();
        String cpf = txtCpf.getText();
        Date dataNasc = dtNasc.getDate() ;

        Cidade cidade = (Cidade) cmbCidade.getSelectedItem();

        char sexo = (char) grpSexo.getSelection().getMnemonic();
        String cep = txtCEP.getText();
        String ender = txtEnder.getText();
        String complemento = txtComplemento.getText();
        String bairro = txtBairro.getText();
        String referencia = txtRef.getText();
        String telFixo = txtTel.getText();
        String celular = txtCelular.getText();
        String email = txtEmail.getText();
        Icon foto = lblFoto.getIcon();
                
        if ( validarCampos() ) {
                
            int num = Integer.parseInt( txtNum.getText() );                     
            
            try {
                
                if ( cliSelecionado == null ) {
                    // INSERIR
                    cliSelecionado = GerInterGrafica.getMyInstance().getGerDominio().inserirCliente(nome, cpf, dataNasc,
                            sexo, cep, ender, num, complemento, bairro, referencia, telFixo, celular, email, foto, cidade);

                    JOptionPane.showMessageDialog(this, "Cliente " + cliSelecionado.getIdCliente() + " inserido com sucesso.", "Cadastro de Cliente", JOptionPane.INFORMATION_MESSAGE);                
                } else {
                    // INSERIR
                    GerInterGrafica.getMyInstance().getGerDominio().alterarCliente(cliSelecionado, nome, cpf, dataNasc,
                            sexo, cep, ender, num, complemento, bairro, referencia, telFixo, celular, email, foto, cidade);

                    JOptionPane.showMessageDialog(this, "Cliente " + cliSelecionado.getIdCliente() + " alterado com sucesso.", "Cadastro de Cliente", JOptionPane.INFORMATION_MESSAGE);                
                    
                }
                
            } catch (ClassNotFoundException | SQLException ex) {
                JOptionPane.showMessageDialog(this, "ERRO ao inserir cliente! " + ex, "Cadastro de Cliente", JOptionPane.ERROR_MESSAGE);
            }
        }
                        
        
    }//GEN-LAST:event_btnNovoActionPerformed

    private void lblFotoMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_lblFotoMouseClicked
        
        JFileChooser janArq = new JFileChooser();
        
        // Configuração da JANELA
        janArq.setMultiSelectionEnabled(false);
        janArq.setFileFilter(  new FileNameExtensionFilter("Imagens", "png", "gif", "jpg", "jpeg" )  );
        janArq.setAcceptAllFileFilterUsed(false);
        
        // Abrir no último diretório aberto. Na primeira vez é NULL
        janArq.setCurrentDirectory(arquivo);
               
        if ( janArq.showOpenDialog(this) == JFileChooser.APPROVE_OPTION ) {
            arquivo = janArq.getSelectedFile();
            
            // Imagem
            Icon foto = new ImageIcon( arquivo.getPath() );           
            FuncoesUteis.mostrarFoto(lblFoto,foto);
            
        }
                
    }//GEN-LAST:event_lblFotoMouseClicked

    private void btnCancelarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCancelarActionPerformed
        limparCampos();
    }//GEN-LAST:event_btnCancelarActionPerformed

    private void txtCEPFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txtCEPFocusLost
        try {
            Endereco ender = FuncoesUteis.consultarCEP( txtCEP.getText() );
            if ( ender != null ) {
                txtEnder.setText(  ender.getLogradouro()  );
                txtBairro.setText( ender.getBairro() );
                txtRef.setText( ender.getCidade() + " - " + ender.getUf() );
                cmbCidade.setSelectedItem( new Cidade( 0 , ender.getCidade() )  );
                
            } else {
                JOptionPane.showMessageDialog(this, "CEP não encontrado!", "Cadastro de Cliente", JOptionPane.ERROR_MESSAGE);
            }
        } catch (IOException ex) {
            JOptionPane.showMessageDialog(this, "ERRO ao consultar CEP!", "Cadastro de Cliente", JOptionPane.ERROR_MESSAGE);
        }
    }//GEN-LAST:event_txtCEPFocusLost

    private void formComponentShown(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_formComponentShown
        GerInterGrafica.getMyInstance().carregarComboCidades(cmbCidade);
    }//GEN-LAST:event_formComponentShown

    private void btnPesquisarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnPesquisarActionPerformed
        cliSelecionado = GerInterGrafica.getMyInstance().abrirPesqCliente();  
        if ( cliSelecionado != null) {
            preencherCampos(cliSelecionado);
        }
        
    }//GEN-LAST:event_btnPesquisarActionPerformed

        
    private void limparCampos() {
            txtNome.setText( "" );
            txtCpf.setText( "" );
            dtNasc.setDate(null);
            txtCEP.setText("");
            txtEnder.setText( "");
            txtNum.setText( "" );
            txtComplemento.setText( "" );
            txtBairro.setText( "" );
            txtRef.setText( "" );
            cmbCidade.setSelectedIndex(0);
            txtTel.setText( "" );
            txtCelular.setText( "");
            txtEmail.setText( "" );
            lblFoto.setText("Foto");
            lblFoto.setIcon(null);
            cliSelecionado = null;
            habilitarBotoes();
    }
    
    private boolean validarCampos() {
        
        String msgErro = "";
        
        lblNome.setForeground(Color.black);
        lblCEP.setForeground(Color.black); 
        lblNum.setForeground(Color.black);
        lblCpf.setForeground(Color.black); 
        
        if ( txtNome.getText().isEmpty() ) {
            msgErro = msgErro + "Digite seu nome.\n";
            lblNome.setForeground(Color.red);            
        }
        
        if ( txtCEP.getText().isEmpty() ) {
            msgErro = msgErro + "Digite seu CEP.\n";
            lblCEP.setForeground(Color.red);            
        }
        
        if ( FuncoesUteis.isCPF( txtCpf.getText() ) == false  ) {
            msgErro = msgErro + "CPF inválido.\n";
            lblCpf.setForeground(Color.red); 
        }
        try {
            int num = Integer.parseInt(txtNum.getText() );
        }
        catch (NumberFormatException erro) {
            msgErro = msgErro + "Número inválido.\n";
            lblNum.setForeground(Color.red); 
        }
        catch (Exception erro) {
            msgErro = msgErro + erro.getMessage() + "\n";
            lblNum.setForeground(Color.red); 
        }
                
        // COLOCAR VALIDAÇÃO DOS OUTROS CAMPOS
        
        if ( msgErro.isEmpty() ) {
            return true;
        } else {            
            JOptionPane.showMessageDialog(this, msgErro, "ERRO Cliente", JOptionPane.ERROR_MESSAGE  );
            return false;
        }
        
    }
    
    private void preencherCampos(Cliente cli) {
        if ( cli != null ) {
            txtNome.setText( cli.getNome() );
            txtCpf.setText( cli.getCpf());
            dtNasc.setDate( cli.getDtNasc() );
            txtCEP.setText( cli.getEndereco().getCep() );
            txtEnder.setText( cli.getEndereco().getLogradouro() );
            txtNum.setText( String.valueOf( cli.getEndereco().getNumero() ) );
            txtComplemento.setText( cli.getEndereco().getComplemento() );
            txtBairro.setText( cli.getEndereco().getBairro() );
            txtRef.setText( cli.getEndereco().getReferencia() );
            cmbCidade.setSelectedItem( cli.getCidade() );
            txtTel.setText( cli.getTelFixo());
            txtCelular.setText( cli.getCelular());
            txtEmail.setText( cli.getEmail() );
            
            if ( cli.getSexo() == 'M' ) {
                rdbMasc.setSelected(true);
            } else {
                rdbFemin.setSelected(true);
            }            
            
            if ( cli.getFoto() != null ) { 
                ImageIcon imagem = new ImageIcon( cli.getFoto() );
                FuncoesUteis.mostrarFoto( lblFoto, imagem);
            } else {
                lblFoto.setText("Foto");
                lblFoto.setIcon(null);
            }
        }
        habilitarBotoes();
    }
    
    private void habilitarBotoes() {
        if ( cliSelecionado == null ) {
            // NOVO
            btnNovo.setVisible(true);
            btnAlterar.setVisible(false);
            
        } else {
            // EDIÇÃO
            btnNovo.setVisible(false);
            btnAlterar.setVisible(true);            
        }
    }
    
   
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAlterar;
    private javax.swing.JButton btnCancelar;
    private javax.swing.JButton btnNovo;
    private javax.swing.JButton btnPesquisar;
    private javax.swing.JComboBox cmbCidade;
    private com.toedter.calendar.JDateChooser dtNasc;
    private javax.swing.ButtonGroup grpSexo;
    private javax.swing.ButtonGroup grpTeste;
    private javax.swing.JFileChooser jFileChooser1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JToggleButton jToggleButton1;
    private javax.swing.JLabel lblCEP;
    private javax.swing.JLabel lblCidade;
    private javax.swing.JLabel lblComplem;
    private javax.swing.JLabel lblCpf;
    private javax.swing.JLabel lblDtNasc;
    private javax.swing.JLabel lblEnder;
    private javax.swing.JLabel lblEnder1;
    private javax.swing.JLabel lblEnder5;
    private javax.swing.JLabel lblEnder6;
    private javax.swing.JLabel lblEnder7;
    private javax.swing.JLabel lblFoto;
    private javax.swing.JLabel lblNome;
    private javax.swing.JLabel lblNum;
    private javax.swing.JLabel lblTelFixo;
    private javax.swing.JRadioButton rdbFemin;
    private javax.swing.JRadioButton rdbMasc;
    private javax.swing.JTextField txtBairro;
    private javax.swing.JFormattedTextField txtCEP;
    private javax.swing.JTextField txtCelular;
    private javax.swing.JTextField txtComplemento;
    private javax.swing.JFormattedTextField txtCpf;
    private javax.swing.JTextField txtEmail;
    private javax.swing.JTextField txtEnder;
    private javax.swing.JTextField txtNome;
    private javax.swing.JTextField txtNum;
    private javax.swing.JTextField txtRef;
    private javax.swing.JTextField txtTel;
    // End of variables declaration//GEN-END:variables
}
