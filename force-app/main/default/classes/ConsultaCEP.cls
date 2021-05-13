public with sharing class ConsultaCEP {
    private String cepConsultado;
    
    public ConsultaCEP(String pCepConsultado) {
        this.cepConsultado = pCepConsultado;
        
    }

    /**
     * Realiza a consulta de CEP
     * return String : Endereço do CEP consultado
     **/
    public String consultarCEP(){
        
        Account contaExistente = obterContaComEsteCEP();
        boolean temUmaConta = contaExistente != null;
        if(temUmaConta){
            return montarEndereco(contaExistente);
        }
        // else
        return procurarCEPNosCorreios();
        
    }

    private String montarEndereco(Account conta){
        // return conta.BillingStreet + ' '+ conta.BillingCity + ' - ' + conta.BillingState;
        String enderecoMontado = conta.BillingStreet + ' '+ conta.BillingCity + ' - ' + conta.BillingState;
        return enderecoMontado;
    }
    private String procurarCEPNosCorreios(){
        String endereco;
        
        System.debug('O CEP consultado foi ' + this.cepConsultado);
        endereco = 'Rua Mario 246, Gopoúva, Guarulhos - SP';
        return endereco;
    }
    private Account obterContaComEsteCEP(){
        List<Account> contasComEsteCEP;
        /*
        Só para estudo, não altera funcionamento
        if(contasComEsteCEP == null){
            System.debug('Aqui ainda está nulo');
        }
        
        contasComEsteCEP = new List<Account>();
        if(contasComEsteCep != null){
            System.debug('Aqui não está mais nulo');
        }*/
        contasComEsteCEP = [SELECT // quais campos
                                    Id, BillingStreet, BillingCity, BillingState
                                // de qual sObject
                                FROM Account 
                                // filtro
                                WHERE BillingPostalCode = :this.cepConsultado];
        
        if(contasComEsteCEP.isEmpty()){
           System.debug('Não tem nenhuma conta com este CEP');
           return null;
        } else{
            return contasComEsteCEP[0];
        }

    }

}