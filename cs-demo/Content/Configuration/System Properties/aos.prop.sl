namespace: ''
properties:
  - war_repo_root_url: 'http://vmdocker.hcm.demo.local:36980/job/AOS/lastSuccessfulBuild/artifact/'
  - vm_username: root
  - vm_password:
      value: admin@123
      sensitive: true
  - script_deploy_war: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/deploy_war.sh'
  - script_install_java: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_java.sh'
  - script_install_postgres: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_postgres.sh'
  - script_install_tomcat: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_tomcat.sh'
  - vcenter_host: 10.0.46.10
  - vcenter_user: "CAPA1\\1022-capa1user"
  - vcenter_password:
      value: Automation123
      sensitive: false
  - vcenter_image: Ubuntu-tm-nw
  - vcenter_datacenter: CAPA1 Datacenter
  - vcenter_folder: Students/Natdanai
