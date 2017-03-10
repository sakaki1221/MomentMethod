# MomentMethod

## 使い方
sample_calcの中にそれぞれのPOTCARが入っています．

神藤さんの従来のMoment法の計算は
```
momentmethod sample_calc/jindo_Cu/POTCAR
```
POTCARのポテンシャルをJに変換した計算は
```
momentmethod --potj sample_calc/jindo_Cu_J/POTCAR
```
VASPを導入したMoment法は
```
momentvasp sample_calc/vasp_Cu/POTCAR.rb
```
となっています．

sample_calcは次のようになる．
```
├── jindo_Ag  　#神藤さんの元のプログラムのポテンシャルデータ
├── jindo_Ag_J  #単位をJに変換し，2で割って1原子あたりのポテンシャルにしたもの．
├── jindo_Au
├── jindo_Au_J
├── jindo_Cu
├── jindo_Cu_J
├── vasp_Ag     #MomentVasp用のPOTCAR．
├── vasp_Al
├── vasp_Au
└── vasp_Cu
```




## vaspの導入法
VASPの計算結果からフィッティングを行い計算に利用します．
最近接原子間距離と１原子あたりのエネルギーのポテンシャル関数を作ってもらえればいいのですが，
修論でおこなった方法を書いておきます．
例としてvasp_exampleディレクトリにCuのVASPの計算結果を置いておきます．
### Maple用のデータの生成
```
/Users/sakaki/Research/momentmethod/vasp_example/unit_lattice_100036% ruby mkdate_e_r2.rb
2.443041918022984 -3.5755615
2.468758148739015 -3.63074325
2.494474379455047 -3.67102375
2.520190610171078 -3.69804675
2.5459068408871097 -3.71330775
2.571623071603141 -3.71811925
2.597339302319172 -3.713645
2.623055533035204 -3.70095875
2.648771763751235 -3.68103425
2.674487994467267 -3.6547425
2.700204225183298 -3.62286225
2.7259204558993297 -3.58612225
2.751636686615361 -3.54517025
2.7773529173313922 -3.50059925
2.803069148047424 -3.45289875
2.828785378763455 -3.402512
```
mkdata_e_r2.rbは95..110ディレクトリから最近接原子間距離と１原子あたりのエネルギーを取り出します(プログラムの作りはかなり雑になってます）．格子の長さはsqrt(2)で割ることで最近接原子間距離に，ポテンシャルを4で割ることで1原子あたりのポテンシャルに変換しています．
このデータをmapleに読ませることになります．
### Mapleでfitting
vasp_example内のfitting_example.mwにフィッティングの例があります．
mapleファイル内では，原子間距離をÅからmにエネルギーをeVからJに変換したのちフィッティングを行い
4次微分の式まで計算してます．
ここで得られた，ポテンシャル関数とそれの2次微分，4次微分からPOTCAR.rbを作っていきます．

### POTCAR.rb
POTCAR.rbの基本形は次のようになります．
```
puts "表示メッセージ"
module Potcar
  LATTICE=最安定距離
  MASS=原子量(g)
  def e_r(x)
    return ポテンシャル関数
  end
  def de2dr2(x)
    return ポテンシャル関数の2次微分
  end

  def de4dr4(x)
    return ポテンシャル関数の4次微分
  end
end
```
* LATTICEは計算に使用するa0になります．
* 原子量の単位は一般的なgです．実際の計算の中では1000で割りkgに変換して利用することになります．
* mapleのfittingで得られる式はそのままコピー，ペーストし，^を**に一括変換することで利用できます．

##原文との違い
Moment法の論文「Nguyen Tang, and Vu Van Hung, Phys. Stat. Sol., 149 (1988), 511.」
と神藤さんのプログラムに使用されているポテンシャルは2原子のポテンシャルとなっています．
これは原文p.33の「Note that this total force is decreased by one harf because we have taken into account the interaction between the i-th particles.」
という文からもわかり，ここで2で割ることによって調整をおこなっています．
修士論文ではポテンシャルを1原子あたりとして記述しているため，k,とgammaが原文と比較すると2倍されていますが，数値で見ると同じ値になります．

##神藤さんのプログラムの単位
元の神藤さんのプログラムの単位について記述しておきます．
* LJ型ポテンシャルにはKelvin
* 内部の計算にはerg
  * 注意点として，計算の単位がergのため，ボルツマン定数，プランク定数は従来の数値より10^-7小さくなっている．

修士論文ではポテンシャルをJに変換し内部の計算もJにしたものを使用している．
最終的な値には変化はないのですが，VASPの導入の際に必要だったため実装しています．
こちらは-potjコマンドで使用可能となってます．

## プログラムについて
### 構造
lib内の構造は次のようになる．
```
├── fortran               元のfortranのプログラム
│   ├── NishiAg
│   ├── NishiAu
│   ├── NishiCu
│   ├── Nishit.f
│   ├── moment_ruby.rb    fortranのプログラムをそのままrubyに変換したもの．
│   └── vhung.fcc.data
├── momentmethod
│   ├── fitting_test.rb   元々のvaspを導入した計算プログラム．POTCARには対応しておらず，プログラムの中に各元素の情報が埋め込まれている．修士論文にはこちらを使用した．
│   ├── momentmethod.rb   従来のmoment法計算．
│   ├── momentmethod_j.rb 従来のmoment法計算，ポテンシャルJ，内部の計算Jバージョン．
│   ├── plotdata.rb       修士論文の一部のデータプロット用のプログラム．
│   └── version.rb
├── momentmethod.rb       momentmethod起動部．optperse使ってる．
├── momentvasp
│   └── momentvasp.rb　   fitting_test.rbをわかりやすくするために移行したもの．POTCAR対応バージョン．
└── momentvasp.rb         momentvaspの起動部．
```

### gammaの計算
gammaの計算に使用している式がmapleと元の神藤さんのプログラムで若干異なります．
gammaの計算はlib/momentmethod/momentmethod.rb内のcalc_gamma関数で定義されており，
神藤さんの元のgammaはstructure=jindofcc, Mapleで計算したものはsakakifccとなっています．

修士論文ではmapleで計算した，sakakifccを使っています．
またstructureの変更は次のように--structureコマンドでできます．
```
momentmethod --structure jindofcc sample_calc/jindo_Cu/POTCAR
```

### Aの計算
修士論文p.7のy_0の不一致に書いてある通り，原文のAとmapleのAで値が異なる．
原文のAの計算はcalc_large_aで，MapleのAの計算はcalc_large_a_mapleでおこなっている．
修士論文では，calc_large_a_mapleをAの計算に使っています．

### MomentVasp
lib/momentvasp/momentvasp.rbの計算部分について説明します．
ほとんどの関数はmomentmethod.rbから継承されています．
momentvasp内で定義される関数は
* calc_k_fitting kの計算
* calc_gamma_fitting gammaの計算
* calc_psi0_linear 線形結合の自由エネルギーの計算
であり，従来のMoment法とは違う計算を行う必要があるので追加しています．

momentvasp.rb内のcalc_moment関数内の計算部分は次のようになります．
また式番号は修士論文の式番号となっています．
```
k = calc_k_fitting(a1)                #kの計算,式(2.8)
atom_mass = MASS/AVOGADO*1e-3         #質量mに対応，gからkgに変換するために1000で割っている．
omega = sqrt(k/atom_mass)             #omega，式(2.8)
x = HBAR2*omega/(2.0*theta)           #x，式(2.8)
gamma = calc_gamma_fitting(a1)        #gamma，式(2.8)
gt_k2 = gamma*theta/k**2              #Aの計算の際に多く出てくるために先に定義されている．
u0 = e_r(a1)                          #内部エネルギーの計算，POTCAR.rb内で定義する．
psi0 = calc_psi0_linear(x,theta)*3    #線形結合の調和振動による自由エネルギー，式(2.18),3でかけているのは3次元にするため，詳しくは修士論文p.15参照．
large_a = calc_large_a_maple(x, gt_k2)　#A計算，式(2.15)
y0 = calc_y0(k, gamma, theta, large_a)  #y0計算，式(2.15)
psi_linear = calc_psi_linear(k, x, gamma, theta)*3 #線形結合の非調和振動による自由エネルギー，式(2.16)の第3項以降．
total_gap = comp_gap + gap[change][same]　#計算に使用したずれyの計算
break if y0 - total_gap < 0               #yとy_0を比較
```

この計算を最近接原子間距離a1を伸ばしながらfor文で繰り返していく．
for文の変数changeはずれの値を10で割った回数，sameはずれを同じ長さで伸ばした回数となる．
