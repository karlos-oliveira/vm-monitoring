# vm-monitoring
Simples script para monitorar e automaticamente reiniciar as vm's da sua instancia do proxmox quando elas travarem

A instalação fica a seu critério, mas abaixo vai uma sugestão de como instalar o script:

1. salve o arquivo **watch_tower.sh** em **/root** e de permissão de execução para o mesmo com o comando **chmod -x watch_tower.sh**
2. digite o comando **crontab -l**
3. no final do arquivo, cole a linha abaixo

` * * * * * /root/watch_tower.sh &> /dev/null`

Isso fará com que o script rode a cada minuto, mas usando a notação do crontab você pode colocar a periodicidade que quiser.
