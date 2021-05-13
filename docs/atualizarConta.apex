// os campos que serão atualizados devem estar na cláusula SELECT do select
Account conta = [SELECT Id,BillingCity FROM Account WHERE BillingPostalCode = '07092030'  ORDER BY CreatedDate ASC LIMIT 1;
conta.BillingCity = 'Guarulhos';
update conta;