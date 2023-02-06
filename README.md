# vm-monitoring
Simples script para monitorar e automaticamente reiniciar as vm's da sua instancia do proxmox quando elas travarem

A instalação fica a seu critério, mas abaixo vai uma sugestão de como instalar o script:

No **Proxmox**, acesse o **node** onde suas vm's se encontram e depois clique em **Shell**

![passo1](https://user-images.githubusercontent.com/45289622/216975240-61cf144c-57c3-4c66-9087-64b18a74972a.png)

1. salve o arquivo **watch_tower.sh** em **/root** e de permissão de execução para o mesmo com o comando **chmod -x watch_tower.sh**
2. digite o comando **crontab -l**
3. no final do arquivo, cole a linha abaixo

` * * * * * /root/watch_tower.sh &> /dev/null`

Isso fará com que o script rode a cada minuto, mas usando a notação do crontab você pode colocar a periodicidade que quiser.
