/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JDialog.java to edit this template
 */
package com.viewer;

import com.controller.graficinterface.GenericTableModel;
import com.controller.graficinterface.GerenciaInterfaceGrafica;
import com.domain.Movimentacao;
import com.viewer.CadastrarBovino;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author lucas
 */
public class GerenciarMovimentacao extends javax.swing.JFrame {
    
    private int contadorID = 1; // Geração automática de ID
    private int linhaEditando = -1; // Armazena a linha que está sendo editada
    private GenericTableModel<Movimentacao> tableModel;
 
    public GerenciarMovimentacao() {
        initComponents();
        
        // Definir as colunas e os atributos da tabela
        String[] colunas = {"ID", "Apelido", "Tipo", "Data", "Destino", "Motivo", "Observações"};
        String[] atributos = {"id", "apelidoAnimal", "tipo", "dataMovimentacao", "destino", "motivo", "observacoes"};

        // Criar o modelo genérico e associar à JTable
        tableModel = new GenericTableModel<>(colunas, atributos);
        tabelaMovimentacao.setModel(tableModel);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jLabel11 = new javax.swing.JLabel();
        cbxAnimal = new javax.swing.JComboBox<>();
        jLabel12 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        cbxTipoMovimentacao = new javax.swing.JComboBox<>();
        cbxMotivo = new javax.swing.JComboBox<>();
        cbxDestino = new javax.swing.JComboBox<>();
        jScrollPane1 = new javax.swing.JScrollPane();
        txtObservacao = new javax.swing.JTextArea();
        jPanel2 = new javax.swing.JPanel();
        btnRegistrar = new javax.swing.JButton();
        Excluir = new javax.swing.JButton();
        btnSalvar = new javax.swing.JButton();
        btnAlterar = new javax.swing.JButton();
        dateDataMovimentacao = new com.toedter.calendar.JDateChooser();
        jPanel3 = new javax.swing.JPanel();
        jScrollPane2 = new javax.swing.JScrollPane();
        tabelaMovimentacao = new javax.swing.JTable();
        jPanel4 = new javax.swing.JPanel();
        jButton6 = new javax.swing.JButton();
        jLabel7 = new javax.swing.JLabel();
        jTextField2 = new javax.swing.JTextField();
        jLabel8 = new javax.swing.JLabel();
        jComboBox4 = new javax.swing.JComboBox<>();
        jLabel9 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        jTextField3 = new javax.swing.JTextField();
        jDateChooser1 = new com.toedter.calendar.JDateChooser();
        jMenuBar1 = new javax.swing.JMenuBar();
        menuRetornar = new javax.swing.JMenu();
        menuVoltarHome = new javax.swing.JMenuItem();
        menuGerenciaFazenda = new javax.swing.JMenu();
        menuGerenciarFazendas = new javax.swing.JMenuItem();
        menuGerenciaGado = new javax.swing.JMenu();
        menuGerenciarGado = new javax.swing.JMenuItem();
        jMenu5 = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setResizable(false);

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Campos Principais", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("URW Gothic", 1, 18))); // NOI18N

        jLabel11.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel11.setText("Animal:");

        cbxAnimal.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "3e33d - \"Loiola\" - Guzera...", "9cw2w - \"Bain\" - Itabapuan..." }));

        jLabel12.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel12.setText("Tipo de Movimentação: ");

        jLabel13.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel13.setText("Data da Movimentação:");

        jLabel14.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel14.setText("Motivo:");

        jLabel15.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel15.setText("Destino: ");

        jLabel16.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel16.setText("Observações:");

        cbxTipoMovimentacao.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Entrada", "Saida", "Transferencia", " " }));

        cbxMotivo.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Compra", "Venda", "Abate", "Transferência" }));

        cbxDestino.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Sitio Recanto dos Sonho", "Frisa", " ", " " }));

        txtObservacao.setColumns(20);
        txtObservacao.setRows(5);
        jScrollPane1.setViewportView(txtObservacao);

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Botões de Acões", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("URW Gothic", 1, 18))); // NOI18N

        btnRegistrar.setText("Registrar");
        btnRegistrar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRegistrarActionPerformed(evt);
            }
        });

        Excluir.setText("Excluir");
        Excluir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ExcluirActionPerformed(evt);
            }
        });

        btnSalvar.setText("Salvar");
        btnSalvar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSalvarActionPerformed(evt);
            }
        });

        btnAlterar.setText("Alterar");
        btnAlterar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAlterarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnAlterar)
                    .addComponent(btnRegistrar))
                .addGap(23, 23, 23)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(Excluir)
                    .addComponent(btnSalvar))
                .addContainerGap(332, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(16, 16, 16)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnSalvar)
                    .addComponent(btnRegistrar))
                .addGap(30, 30, 30)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnAlterar)
                    .addComponent(Excluir))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        dateDataMovimentacao.setBackground(new java.awt.Color(255, 255, 255));
        dateDataMovimentacao.setFont(new java.awt.Font("URW Gothic", 1, 15)); // NOI18N

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel11)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cbxAnimal, javax.swing.GroupLayout.PREFERRED_SIZE, 205, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel12)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(cbxTipoMovimentacao, javax.swing.GroupLayout.PREFERRED_SIZE, 132, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel13)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(dateDataMovimentacao, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel14)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cbxMotivo, javax.swing.GroupLayout.PREFERRED_SIZE, 182, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel15)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cbxDestino, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel16, javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(14, 14, 14)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel11)
                    .addComponent(cbxAnimal, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel12)
                    .addComponent(cbxTipoMovimentacao, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel13)
                    .addComponent(dateDataMovimentacao, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel14)
                    .addComponent(cbxMotivo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel15)
                    .addComponent(cbxDestino, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jLabel16)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jPanel3.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Movimentações Registradas", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("URW Gothic", 1, 18))); // NOI18N

        tabelaMovimentacao.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "ID", "Apelido", "Tipo", "Data", "Destino", "Motivo", "Observações"
            }
        ));
        tabelaMovimentacao.setRowHeight(50);
        tabelaMovimentacao.setShowGrid(true);
        jScrollPane2.setViewportView(tabelaMovimentacao);

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 1202, Short.MAX_VALUE)
                .addContainerGap())
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 820, Short.MAX_VALUE)
                .addContainerGap())
        );

        jPanel4.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Buscar", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("URW Gothic", 1, 18))); // NOI18N

        jButton6.setText("Buscar");

        jLabel7.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel7.setText("Fazenda:");

        jLabel8.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel8.setText("Raça :");

        jComboBox4.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Nelore", "Angus" }));

        jLabel9.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel9.setText("Data :");

        jLabel10.setFont(new java.awt.Font("URW Gothic", 1, 18)); // NOI18N
        jLabel10.setText("Identificador :");

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(jLabel8)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jComboBox4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(jButton6)
                        .addGap(36, 36, 36)
                        .addComponent(jLabel7)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE, 329, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(jLabel9)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jDateChooser1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(jLabel10)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, 329, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(27, Short.MAX_VALUE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButton6)
                    .addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel7))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jComboBox4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel8))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel9)
                    .addComponent(jDateChooser1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel10)
                    .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(152, Short.MAX_VALUE))
        );

        menuRetornar.setIcon(new javax.swing.ImageIcon("/home/lucas/NetBeansProjects/FarmFormII/src/resorces/imagens/home.png")); // NOI18N
        menuRetornar.setText("Home");

        menuVoltarHome.setText("Voltar");
        menuVoltarHome.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuVoltarHomeActionPerformed(evt);
            }
        });
        menuRetornar.add(menuVoltarHome);

        jMenuBar1.add(menuRetornar);

        menuGerenciaFazenda.setIcon(new javax.swing.ImageIcon("/home/lucas/NetBeansProjects/FarmFormII/src/resorces/fazenda_16x16.png")); // NOI18N
        menuGerenciaFazenda.setText("Fazenda");

        menuGerenciarFazendas.setText("Gerenciar Fazendas");
        menuGerenciarFazendas.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuGerenciarFazendasActionPerformed(evt);
            }
        });
        menuGerenciaFazenda.add(menuGerenciarFazendas);

        jMenuBar1.add(menuGerenciaFazenda);

        menuGerenciaGado.setIcon(new javax.swing.ImageIcon("/home/lucas/NetBeansProjects/FarmFormII/src/resorces/boi_16x16.png")); // NOI18N
        menuGerenciaGado.setText("Gado");

        menuGerenciarGado.setText("Gerenciamento de Gado");
        menuGerenciarGado.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuGerenciarGadoActionPerformed(evt);
            }
        });
        menuGerenciaGado.add(menuGerenciarGado);

        jMenuBar1.add(menuGerenciaGado);

        jMenu5.setIcon(new javax.swing.ImageIcon("/home/lucas/NetBeansProjects/FarmFormII/src/resorces/imagens/note_edit.png")); // NOI18N
        jMenu5.setText("Relatorio");
        jMenuBar1.add(jMenu5);

        setJMenuBar(jMenuBar1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(132, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnRegistrarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRegistrarActionPerformed
        inserirMovimentacao();
    }//GEN-LAST:event_btnRegistrarActionPerformed

    private void menuGerenciarFazendasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuGerenciarFazendasActionPerformed
        GerenciaInterfaceGrafica.getInstance().abrirTela("GerenciarFazenda");
    }//GEN-LAST:event_menuGerenciarFazendasActionPerformed

    private void menuGerenciarGadoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuGerenciarGadoActionPerformed
        GerenciaInterfaceGrafica.getInstance().abrirTela("CadastrarBovino");
    }//GEN-LAST:event_menuGerenciarGadoActionPerformed

    private void menuVoltarHomeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuVoltarHomeActionPerformed
        GerenciaInterfaceGrafica.getInstance().abrirTela("Home");
    }//GEN-LAST:event_menuVoltarHomeActionPerformed

    private void btnAlterarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAlterarActionPerformed
        carregarDadosParaCampos();
    }//GEN-LAST:event_btnAlterarActionPerformed

    private void ExcluirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ExcluirActionPerformed
        excluirMovimentacao();
    }//GEN-LAST:event_ExcluirActionPerformed

    private void btnSalvarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSalvarActionPerformed
        salvarAlteracoes();
    }//GEN-LAST:event_btnSalvarActionPerformed

    // 🔹 Obtém os dados preenchidos e cria um objeto Movimentacao
    private Movimentacao obterMovimentacaoFormulario() {
        try {
            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
            Date dataMovimentacao = dateDataMovimentacao.getDate();

            String animal = cbxAnimal.getSelectedItem().toString();
            String tipo = cbxTipoMovimentacao.getSelectedItem().toString();
            String motivo = cbxMotivo.getSelectedItem().toString();
            String destino = cbxDestino.getSelectedItem().toString();
            String observacoes = txtObservacao.getText().trim();

            if (animal.isEmpty() || dataMovimentacao == null) {
                mostrarMensagem("Preencha todos os campos obrigatórios!", "Erro", JOptionPane.ERROR_MESSAGE);
                return null;
            }

            return new Movimentacao(contadorID++, animal, tipo, dataMovimentacao, destino, motivo, observacoes);
        } catch (Exception e) {
            mostrarMensagem("Erro ao obter dados do formulário!", "Erro", JOptionPane.ERROR_MESSAGE);
            return null;
        }
    }

    // 🔹 Método principal chamado ao clicar no botão "Inserir"
    private void inserirMovimentacao() {
        Movimentacao novaMovimentacao = obterMovimentacaoFormulario();
        if (novaMovimentacao == null) return;

        tableModel.adicionar(novaMovimentacao);
        limparCampos();
        mostrarMensagem("Movimentação cadastrada com sucesso!", "Sucesso", JOptionPane.INFORMATION_MESSAGE);
    }

    // 🔹 Método para carregar os dados da tabela para os campos
    private void carregarDadosParaCampos() {
        int linhaSelecionada = tabelaMovimentacao.getSelectedRow();
        if (linhaSelecionada == -1) {
            mostrarMensagem("Selecione uma movimentação para alterar!", "Erro", JOptionPane.ERROR_MESSAGE);
            return;
        }

        Movimentacao movSelecionada = tableModel.getLista().get(linhaSelecionada);

        cbxAnimal.setSelectedItem(movSelecionada.getApelidoAnimal());
        cbxTipoMovimentacao.setSelectedItem(movSelecionada.getTipo());
        cbxMotivo.setSelectedItem(movSelecionada.getMotivo());
        cbxDestino.setSelectedItem(movSelecionada.getDestino());
        txtObservacao.setText(movSelecionada.getObservacoes());
        dateDataMovimentacao.setDate(movSelecionada.getDataMovimentacao());

        linhaEditando = linhaSelecionada;
    }

    // 🔹 Método para salvar as alterações
    private void salvarAlteracoes() {
        if (linhaEditando == -1) {
            mostrarMensagem("Nenhuma edição em andamento!", "Erro", JOptionPane.ERROR_MESSAGE);
            return;
        }

        Movimentacao movEditada = obterMovimentacaoFormulario();
        if (movEditada == null) return;

        Movimentacao movOriginal = tableModel.getLista().get(linhaEditando);
        movEditada.setId(movOriginal.getId()); // Mantém o mesmo ID

        tableModel.getLista().set(linhaEditando, movEditada);
        tableModel.fireTableRowsUpdated(linhaEditando, linhaEditando);

        linhaEditando = -1;
        limparCampos();
        mostrarMensagem("Alteração realizada com sucesso!", "Sucesso", JOptionPane.INFORMATION_MESSAGE);
    }

    // 🔹 Método para excluir uma movimentação
    private void excluirMovimentacao() {
        int linhaSelecionada = tabelaMovimentacao.getSelectedRow();
        if (linhaSelecionada == -1) {
            mostrarMensagem("Selecione uma movimentação para excluir!", "Erro", JOptionPane.ERROR_MESSAGE);
            return;
        }

        int confirmacao = JOptionPane.showConfirmDialog(this, "Deseja excluir esta movimentação?", "Confirmação", JOptionPane.YES_NO_OPTION);
        if (confirmacao == JOptionPane.NO_OPTION) return;

        tableModel.remover(linhaSelecionada);
        mostrarMensagem("Movimentação excluída com sucesso!", "Sucesso", JOptionPane.INFORMATION_MESSAGE);
    }

    // 🔹 Método para limpar os campos
    private void limparCampos() {
        cbxAnimal.setSelectedIndex(0);
        cbxTipoMovimentacao.setSelectedIndex(0);
        dateDataMovimentacao.setDate(null);
        cbxMotivo.setSelectedIndex(0);
        cbxDestino.setSelectedIndex(0);
        txtObservacao.setText("");
        cbxAnimal.requestFocus();
    }

    // 🔹 Método para exibir mensagens ao usuário
    private void mostrarMensagem(String mensagem, String titulo, int tipo) {
        JOptionPane.showMessageDialog(this, mensagem, titulo, tipo);
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
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(GerenciarMovimentacao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(GerenciarMovimentacao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(GerenciarMovimentacao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(GerenciarMovimentacao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                GerenciarMovimentacao dialog = new GerenciarMovimentacao();
                dialog.addWindowListener(new java.awt.event.WindowAdapter() {
                    @Override
                    public void windowClosing(java.awt.event.WindowEvent e) {
                        System.exit(0);
                    }
                });
                dialog.setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton Excluir;
    private javax.swing.JButton btnAlterar;
    private javax.swing.JButton btnRegistrar;
    private javax.swing.JButton btnSalvar;
    private javax.swing.JComboBox<String> cbxAnimal;
    private javax.swing.JComboBox<String> cbxDestino;
    private javax.swing.JComboBox<String> cbxMotivo;
    private javax.swing.JComboBox<String> cbxTipoMovimentacao;
    private com.toedter.calendar.JDateChooser dateDataMovimentacao;
    private javax.swing.JButton jButton6;
    private javax.swing.JComboBox<String> jComboBox4;
    private com.toedter.calendar.JDateChooser jDateChooser1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JMenu jMenu5;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTextField jTextField2;
    private javax.swing.JTextField jTextField3;
    private javax.swing.JMenu menuGerenciaFazenda;
    private javax.swing.JMenu menuGerenciaGado;
    private javax.swing.JMenuItem menuGerenciarFazendas;
    private javax.swing.JMenuItem menuGerenciarGado;
    private javax.swing.JMenu menuRetornar;
    private javax.swing.JMenuItem menuVoltarHome;
    private javax.swing.JTable tabelaMovimentacao;
    private javax.swing.JTextArea txtObservacao;
    // End of variables declaration//GEN-END:variables
}
