

## ElasticBeanstalk 배포 환경 구성하기

> 쉘 스크립트 실행 전 `homebrew`가 설치되어 있어야 합니다.
> * [homebrew 설치](https://brew.sh/index_ko)

<br>

### 최초 배포 시 환경 설정 파일 작성
1. `.ebextensions`디렉토리 하위의 `00-env.config`,`01-env.config`파일을 배포할 애플리케이션에 맞게 작성한다 (환경 변수, ec2 인스턴스 용량 등). 상세 옵션은 아래를 참조한다.
   * 변경 가능성 *낮은* 설정 파일 : `00-env.config` 수정
   * 변경 가능성 *높은* 설정 파일 : `01-env.config` 수정
   * [환경에 대한 옵션](https://docs.aws.amazon.com/ko_kr/ko_kr/elasticbeanstalk/latest/dg/command-options-general.html)

2. `Procfile`의 `web: java -jar build/libs/*.jar`에서 `*.jar` 부분을 해당 애플리케이션의 빌드된 jar파일명으로 변경한다.

---

### EB 배포

1. 프로젝트 루트에서 `eb.sh` 쉘 스크립트를 실행한다.
```
$ ./eb.sh
```

2. AWS 키를 입력한다.
```
$ (access_key) : 
$ (secret_key) :
```

3. 신규 eb 또는 기존 eb를 선택하고 값을 입력한다.
```
Select an application to use
4) discovery
5) configuration
6) tptp
7) user-new-prod
8) signup
9) user-signup
10) user-signup-prod
11) login
12) iamport
13) toss
14) point
15) refund
16) notifier
17) bot
.
.
.
${x}) [ Create new Application ]
(default is ${x} ): 
```

4. aws 코드 커밋을 사용할건지 묻는다. `n`을 입력한다.
```
Do you wish to continue with CodeCommit? (Y/n): 
```

5. 환경명을 입력한다.
```
Enter Environment Name
(default is xxx-dev) : 
```

* 신규 eb 환경 생성시 네이밍 규칙 : `${bc.name}.${modulename}.${awsResourceName}.${profile}`
    * ex ) member.consumer.eb.prod
  
<br>

6. DNS의 CNAME을 입력한다. 위 환경명과 동일한 이름을 사용한다.
```
Enter DNS CNAME prefix
(default is xxx-dev): 
```

7. 해당 EB의 로드 밸런서를 선택한다. default 값을 사용한다.
```
Select a load balancer type
1) classic
2) application
3) network
(default is 2): 
```

8. 공유 로드밸런서를 사용할지 묻는다. `n`을 입력한다.
```
Your account has one or more sharable load balancers. Would you like your new environment to use a shared load balancer? (y/N): 
```

9. EC2 스팟 환경을 사용하는지 묻는다. `n`을 입력한다. 
```
Would you like to enable Spot Fleet requests for this environment? (y/N): 
```

10. `/.extensions`,`/.elasticbeanstalk`내부 config 파일을 바탕으로 eb 애플리케이션과 배포 환경이 구성된다.

---

## 개선점

- 쉘 스크립트를 통해 eb 애플리케이션 이름 설정과 환경 이름 설정을 제외한 모든 작업을 자동화 한다.

  - 이름 설정도 지정된 네이밍 규칙으로 자동화?

[ElasticBeanstalk Docs](https://docs.aws.amazon.com/ko_kr/elasticbeanstalk/latest/dg/command-options-general.html)
