package viewer;






import controller.GenericTableModel;
import controller.GerInterGrafica;
import controller.TableModelItemPedido;
import domain.ItemPedido;
import domain.Lanche;
import java.util.List;
import javax.swing.JCheckBox;
import javax.swing.JOptionPane;
import javax.swing.JRadioButton;
import javax.swing.JSpinner;
import javax.swing.table.DefaultTableModel;





/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author 1547816
 */
public class DlgCadPedido extends javax.swing.JDialog {
   
    private float valorTotal;
    private float novoValor;
    
    private GenericTableModel<ItemPedido> tableModelItemPedido;    
   
    public DlgCadPedido(java.awt.Frame parent, boolean modal) {
        initComponents();

        valorTotal = (float) 0.0;
        novoValor = (float) 0.0;
        
        // Definir as colunas e os atributos da tabela
        String[] colunas = {"Lanche","Qtd","Bife","Ovo","Presunto","Queijo","Ingredientes"};
        String[] atributos = {"lanche","qtd","maisBife","maisOvo","maisPresunto","maisQueijo","ingredientes"}; //Iguais aos campos do objeto
        
        // Amarro o JTable com o meu Abstract Table Model
        tableModelItemPedido = new GenericTableModel<>(colunas, atributos);
        tblPedido.setModel(tableModelItemPedido);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        grpEntrega = new javax.swing.ButtonGroup();
        mnuPopTabela = new javax.swing.JPopupMenu();
        mnuInserir = new javax.swing.JMenuItem();
        mnuExcluir = new javax.swing.JMenuItem();
        mnuPopTeste = new javax.swing.JPopupMenu();
        jMenuItem1 = new javax.swing.JMenuItem();
        jMenuItem2 = new javax.swing.JMenuItem();
        jSeparator1 = new javax.swing.JPopupMenu.Separator();
        jMenuItem3 = new javax.swing.JMenuItem();
        jPanel1 = new javax.swing.JPanel();
        lblNome = new javax.swing.JLabel();
        lblLanche = new javax.swing.JLabel();
        cmbLanche = new javax.swing.JComboBox();
        txtNome = new javax.swing.JTextField();
        btnPesqCli = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        lstIngredientes = new javax.swing.JList();
        jPanel3 = new javax.swing.JPanel();
        chkBife = new javax.swing.JCheckBox();
        spnBife = new javax.swing.JSpinner();
        chkQueijo = new javax.swing.JCheckBox();
        spnQueijo = new javax.swing.JSpinner();
        chkPresunto = new javax.swing.JCheckBox();
        spnPresunto = new javax.swing.JSpinner();
        chkOvo = new javax.swing.JCheckBox();
        spnOvo = new javax.swing.JSpinner();
        jPanel4 = new javax.swing.JPanel();
        rdbSim = new javax.swing.JRadioButton();
        rdbNao = new javax.swing.JRadioButton();
        lblValor = new javax.swing.JLabel();
        btnAddLanche = new javax.swing.JButton();
        jLabel2 = new javax.swing.JLabel();
        spnQtde = new javax.swing.JSpinner();
        btnNovo = new javax.swing.JButton();
        btnCancelar = new javax.swing.JButton();
        jPanel5 = new javax.swing.JPanel();
        jScrollPane2 = new javax.swing.JScrollPane();
        tblPedido = new javax.swing.JTable();

        mnuInserir.setText("Inserir");
        mnuInserir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAddLancheActionPerformed(evt);
            }
        });
        mnuPopTabela.add(mnuInserir);

        mnuExcluir.setText("Excluir");
        mnuExcluir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                mnuExcluirActionPerformed(evt);
            }
        });
        mnuPopTabela.add(mnuExcluir);

        jMenuItem1.setText("jMenuItem1");
        mnuPopTeste.add(jMenuItem1);

        jMenuItem2.setText("jMenuItem2");
        mnuPopTeste.add(jMenuItem2);
        mnuPopTeste.add(jSeparator1);

        jMenuItem3.setText("jMenuItem3");
        mnuPopTeste.add(jMenuItem3);

        setTitle("Cadastro de Pedidos");
        setModal(true);
        setResizable(false);
        addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentShown(java.awt.event.ComponentEvent evt) {
                formComponentShown(evt);
            }
        });

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder("Cadastro de Pedido"));
        jPanel1.setComponentPopupMenu(mnuPopTeste);

        lblNome.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        lblNome.setText("Nome");

        lblLanche.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        lblLanche.setText("Lanche");

        cmbLanche.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                cmbLancheItemStateChanged(evt);
            }
        });

        btnPesqCli.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/png/16x16/search.png"))); // NOI18N

        lstIngredientes.setModel(new javax.swing.AbstractListModel() {
            String[] strings = { "Banana", "Queijo cheddar", "Catupiry", "Batata palha", "Maionese", "Milho verde" };
            public int getSize() { return strings.length; }
            public Object getElementAt(int i) { return strings[i]; }
        });
        lstIngredientes.setSelectedIndices(new int[] {-1});
        jScrollPane1.setViewportView(lstIngredientes);

        jPanel3.setBorder(javax.swing.BorderFactory.createTitledBorder("++ Mais ++"));
        jPanel3.setComponentPopupMenu(mnuPopTeste);
        jPanel3.setLayout(new java.awt.GridLayout(4, 2));

        chkBife.setMnemonic('1');
        chkBife.setText("Bife");
        chkBife.setComponentPopupMenu(mnuPopTeste);
        chkBife.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                chkBifeActionPerformed(evt);
            }
        });
        jPanel3.add(chkBife);

        spnBife.setModel(new javax.swing.SpinnerNumberModel(0, 0, 5, 1));
        spnBife.setComponentPopupMenu(mnuPopTeste);
        spnBife.setEnabled(false);
        jPanel3.add(spnBife);

        chkQueijo.setMnemonic('2');
        chkQueijo.setText("Queijo");
        chkQueijo.setComponentPopupMenu(mnuPopTeste);
        chkQueijo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                chkQueijoActionPerformed(evt);
            }
        });
        jPanel3.add(chkQueijo);

        spnQueijo.setModel(new javax.swing.SpinnerNumberModel(0, 0, 5, 1));
        spnQueijo.setComponentPopupMenu(mnuPopTeste);
        spnQueijo.setEnabled(false);
        jPanel3.add(spnQueijo);

        chkPresunto.setMnemonic('3');
        chkPresunto.setText("Presunto");
        chkPresunto.setComponentPopupMenu(mnuPopTeste);
        chkPresunto.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                chkPresuntoActionPerformed(evt);
            }
        });
        jPanel3.add(chkPresunto);

        spnPresunto.setModel(new javax.swing.SpinnerNumberModel(0, 0, 5, 1));
        spnPresunto.setComponentPopupMenu(mnuPopTeste);
        spnPresunto.setEnabled(false);
        jPanel3.add(spnPresunto);

        chkOvo.setText("Ovo");
        chkOvo.setComponentPopupMenu(mnuPopTeste);
        chkOvo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                chkOvoActionPerformed(evt);
            }
        });
        jPanel3.add(chkOvo);

        spnOvo.setModel(new javax.swing.SpinnerNumberModel(0, 0, 5, 1));
        spnOvo.setComponentPopupMenu(mnuPopTeste);
        spnOvo.setEnabled(false);
        jPanel3.add(spnOvo);

        jPanel4.setBorder(javax.swing.BorderFactory.createTitledBorder("Entregar"));
        jPanel4.setComponentPopupMenu(mnuPopTeste);
        jPanel4.setLayout(new java.awt.BorderLayout());

        grpEntrega.add(rdbSim);
        rdbSim.setMnemonic('S');
        rdbSim.setText("Sim");
        rdbSim.setActionCommand("Sim");
        rdbSim.setComponentPopupMenu(mnuPopTeste);
        jPanel4.add(rdbSim, java.awt.BorderLayout.CENTER);

        grpEntrega.add(rdbNao);
        rdbNao.setMnemonic('N');
        rdbNao.setSelected(true);
        rdbNao.setText("Não");
        rdbNao.setActionCommand("Não");
        rdbNao.setComponentPopupMenu(mnuPopTeste);
        jPanel4.add(rdbNao, java.awt.BorderLayout.PAGE_START);

        lblValor.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        lblValor.setForeground(new java.awt.Color(102, 102, 255));
        lblValor.setText("R$ 0,0");

        btnAddLanche.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/add.png"))); // NOI18N
        btnAddLanche.setText(" Lanche");
        btnAddLanche.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAddLancheActionPerformed(evt);
            }
        });

        jLabel2.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        jLabel2.setText("Qtde");

        spnQtde.setModel(new javax.swing.SpinnerNumberModel(1, 0, 10, 1));
        spnQtde.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                spnQtdeStateChanged(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jScrollPane1)
                                .addGap(4, 4, 4)
                                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, 188, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(9, 9, 9))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                                        .addComponent(lblNome)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED))
                                    .addGroup(jPanel1Layout.createSequentialGroup()
                                        .addComponent(lblLanche)
                                        .addGap(7, 7, 7)))
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(txtNome, javax.swing.GroupLayout.PREFERRED_SIZE, 203, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(cmbLanche, javax.swing.GroupLayout.PREFERRED_SIZE, 203, javax.swing.GroupLayout.PREFERRED_SIZE))))
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel2, javax.swing.GroupLayout.DEFAULT_SIZE, 31, Short.MAX_VALUE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(spnQtde, javax.swing.GroupLayout.PREFERRED_SIZE, 53, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(112, 112, 112))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(lblValor)
                                    .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, 78, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addGap(0, 0, Short.MAX_VALUE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(btnPesqCli, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(btnAddLanche)
                        .addGap(20, 20, 20))))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnPesqCli)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(lblNome)
                        .addComponent(txtNome, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(7, 7, 7)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblLanche)
                            .addComponent(cmbLanche, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, 123, Short.MAX_VALUE)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel2)
                            .addComponent(spnQtde, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, 74, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(lblValor)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnAddLanche)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        btnNovo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/accept.png"))); // NOI18N
        btnNovo.setText("Novo");

        btnCancelar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/remove.png"))); // NOI18N
        btnCancelar.setText("Cancelar");

        jPanel5.setBorder(javax.swing.BorderFactory.createTitledBorder("Lista de Lanches"));
        jPanel5.setLayout(new java.awt.BorderLayout());

        tblPedido.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Nome", "Lanche", "Qtde", "Bife", "Queijo", "Ovo", "Presunto", "Entrega", "Ingredientes"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false, false, false, true
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        tblPedido.setComponentPopupMenu(mnuPopTabela);
        tblPedido.setRowHeight(15);
        tblPedido.setShowGrid(true);
        jScrollPane2.setViewportView(tblPedido);

        jPanel5.add(jScrollPane2, java.awt.BorderLayout.CENTER);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(layout.createSequentialGroup()
                .addGap(125, 125, 125)
                .addComponent(btnNovo, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(57, 57, 57)
                .addComponent(btnCancelar)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, 155, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(1, 1, 1)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnNovo)
                    .addComponent(btnCancelar))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void chkBifeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_chkBifeActionPerformed
        habilitarSpinner(chkBife, spnBife);                
    }//GEN-LAST:event_chkBifeActionPerformed

    private void chkQueijoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_chkQueijoActionPerformed
        habilitarSpinner(chkQueijo, spnQueijo);                
    }//GEN-LAST:event_chkQueijoActionPerformed

    private void chkPresuntoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_chkPresuntoActionPerformed
        habilitarSpinner(chkPresunto, spnPresunto);                
    }//GEN-LAST:event_chkPresuntoActionPerformed

    private void chkOvoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_chkOvoActionPerformed
        habilitarSpinner(chkOvo, spnOvo);                
    }//GEN-LAST:event_chkOvoActionPerformed

    private void btnAddLancheActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAddLancheActionPerformed
        
        String nome = txtNome.getText();        
        Lanche lanche = (Lanche) cmbLanche.getSelectedItem();
        List lista = lstIngredientes.getSelectedValuesList();
        
        int maisBife = Integer.parseInt(  spnBife.getValue().toString() ) ;
        int maisQueijo = Integer.parseInt(  spnQueijo.getValue().toString() ) ;
        int maisPresunto = Integer.parseInt(  spnPresunto.getValue().toString() ) ;
        int maisOvo = Integer.parseInt(  spnOvo.getValue().toString() ) ;
        int qtde = Integer.parseInt(  spnQtde.getValue().toString() ) ;
        
        char entrega = (char) grpEntrega.getSelection().getMnemonic();
        
        //System.out.println( grpEntrega.getSelection().getActionCommand() ) ;
        
        inserirTabela(nome, lanche, lista, maisBife, maisQueijo, maisPresunto, 
                      maisOvo, qtde, entrega);
        
        valorTotal = valorTotal + novoValor;
    }//GEN-LAST:event_btnAddLancheActionPerformed

    private void mnuExcluirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_mnuExcluirActionPerformed
        int linha = tblPedido.getSelectedRow();
        
        if ( linha >= 0 ) {
            // Excluir
            
            if ( JOptionPane.showConfirmDialog(this, "Deseja excluir o lanche?", 
                    "Cadastro de Pedidos", JOptionPane.YES_NO_OPTION) == JOptionPane.OK_OPTION ) {
            
                // Atualizar valor total
                ItemPedido ip = (ItemPedido) tableModelItemPedido.getItem(linha);                
                
                novoValor = ip.getLanche().getValor() * ip.getQtde() ;
                valorTotal = valorTotal - novoValor;
                lblValor.setText("R$ " + valorTotal );
                
                
                // ( (DefaultTableModel) tblPedido.getModel() ).removeRow(linha);
                tableModelItemPedido.remover(linha);
            }
            
        } else {
            // Mensagem de erro
            JOptionPane.showMessageDialog(this, "Selecione uma linha.", "Cadastro de Pedido", JOptionPane.ERROR_MESSAGE   );
        }
    }//GEN-LAST:event_mnuExcluirActionPerformed

    private void formComponentShown(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_formComponentShown
        GerInterGrafica.getMyInstance().carregarComboLanches(cmbLanche);
    }//GEN-LAST:event_formComponentShown

    private void cmbLancheItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_cmbLancheItemStateChanged
        atualizarValorTotal();
    }//GEN-LAST:event_cmbLancheItemStateChanged

    private void spnQtdeStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_spnQtdeStateChanged
        atualizarValorTotal();
    }//GEN-LAST:event_spnQtdeStateChanged

    
    private void habilitarSpinner( JCheckBox chk, JSpinner spn) {
        if ( chk.isSelected()  ) {
            spn.setEnabled(true);
        } else {
            spn.setEnabled(false);
            spn.setValue(0);
        }
    }
    
    private void inserirTabela(String nome, Lanche lanche, List lista, int maisBife, 
              int maisQueijo, int maisPresunto, int maisOvo, int qtde, char entrega) {
        
        /** 
        // Adicionar na tabela uma linha vazia
        ( (DefaultTableModel) tblPedido.getModel() ).addRow( new Object[9] );
        int linha = tblPedido.getRowCount() - 1 ;
        
        int col = 0; 
        tblPedido.setValueAt(nome, linha, col++);
        tblPedido.setValueAt(lanche, linha, col++);
        tblPedido.setValueAt(qtde, linha, col++);
        tblPedido.setValueAt(maisBife, linha, col++);
        tblPedido.setValueAt(maisQueijo, linha, col++);
        tblPedido.setValueAt(maisOvo, linha, col++);
        tblPedido.setValueAt(maisPresunto, linha, col++);
        tblPedido.setValueAt(entrega, linha, col++);
        tblPedido.setValueAt(lista, linha, col++);
            
            * */
               
        ItemPedido item = new ItemPedido(lanche, qtde, maisBife, maisOvo, maisPresunto, maisQueijo, "", lista);
        tableModelItemPedido.adicionar(item);
    }
    
    
    private void atualizarValorTotal() {
        int qtde;
        Lanche lanche;
        
        qtde = (int) spnQtde.getValue();
        lanche = (Lanche) cmbLanche.getSelectedItem();
        novoValor = qtde * lanche.getValor();
        
        lblValor.setText("R$ " + (valorTotal + novoValor) );
    }


    
    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAddLanche;
    private javax.swing.JButton btnCancelar;
    private javax.swing.JButton btnNovo;
    private javax.swing.JButton btnPesqCli;
    private javax.swing.JCheckBox chkBife;
    private javax.swing.JCheckBox chkOvo;
    private javax.swing.JCheckBox chkPresunto;
    private javax.swing.JCheckBox chkQueijo;
    private javax.swing.JComboBox cmbLanche;
    private javax.swing.ButtonGroup grpEntrega;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JMenuItem jMenuItem1;
    private javax.swing.JMenuItem jMenuItem2;
    private javax.swing.JMenuItem jMenuItem3;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JPopupMenu.Separator jSeparator1;
    private javax.swing.JLabel lblLanche;
    private javax.swing.JLabel lblNome;
    private javax.swing.JLabel lblValor;
    private javax.swing.JList lstIngredientes;
    private javax.swing.JMenuItem mnuExcluir;
    private javax.swing.JMenuItem mnuInserir;
    private javax.swing.JPopupMenu mnuPopTabela;
    private javax.swing.JPopupMenu mnuPopTeste;
    private javax.swing.JRadioButton rdbNao;
    private javax.swing.JRadioButton rdbSim;
    private javax.swing.JSpinner spnBife;
    private javax.swing.JSpinner spnOvo;
    private javax.swing.JSpinner spnPresunto;
    private javax.swing.JSpinner spnQtde;
    private javax.swing.JSpinner spnQueijo;
    private javax.swing.JTable tblPedido;
    private javax.swing.JTextField txtNome;
    // End of variables declaration//GEN-END:variables
}
