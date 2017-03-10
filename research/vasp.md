# vaspを組み込む
ポテンシャルをeVで扱えるように修正する．
## まずは単位確認
もともと
* ポテンシャル
  * kelvin
* ボルツマン定数
  * BOLTZ = 1.38064852e-16
  * $1.38064852×10^{−23} J/K$
* プランク定数
  * PLANCK = 6.626e-27
  * $6.62607004 × 10^{-34} Js$
* アボガドロ定数
  * AVOGADO = 6.023e23
  * $6.022140857×10^{23} 1/mol$

# 進捗
* 元のポテンシャルをJに変換
4125.70*1.38064852e-16に
．
1erg=10**-7J
erg=dyn/cm
J=N/m
dyn=g.cm/s**2
kg.m/s**2

質量を考慮すると上手くJで実装することができた．

#　fitting
Cuのvaspfittingをそのまま従来のkの計算に代入するとa2の値で大きな差異が出て負の値を取ってしまう

kの比較1-4項とその和
```
"fitting"
-3.108205879520055e-09
-24.74030058668219
-2030.538567312386
-383.4050622873846
-1844.5448315416404
"origin"
110.69848608236298
-2.8205518398516927
-3.4616194218706235
1.4102759199256707
105.82659074056633
```

vaspの計算は原子を配置を考慮しているため，従来のkの式を無視して実装してみる．
とりあえず，kだけ実装はいけた

```
-10
2.520773221358052 10   
-10
3.564911676 10   
590.217775
-20.58015873
-128.0456612
-93.42949034
348.1624648
104.8815193
-2.118305310
-3.414065486
1.383627661
100.7327762
295.1088868
```

# memo
もともとの方はy0は徐々に伸びてる

# Cuのデータ計算精度あげてみる
データをmapleに読み込めるプログラムを作った
/Users/sakaki/Research/momentmethod/vasp/MM/Cu/unit_lattice_accurate/test.rb

# k,gamma,y0をプロットしてみる．
fitting_test.rb内にk,gamma,y0をプロットするメソッドを作成する．

# 修士論文
phonopyの計算精度による比較を行う
maple fitting2に精度の高いCuのフィッティングを行う.
fittingでは精度の低いものを張っている．
fitting_test.rbは現状元素の変更をPOTCARファイルで行うだけでなく，includeを変えないといけない．
Ag,AuPOTCAR違ったので投げなおし
medeaAu_104の計算し直し
medea Alの計算
phonopy Alの精度比較

bundle exec  exe/momentmethod --fittingtest
vaspfittingの実行コマンド，includeを変える必要がある

phonopy cu ag au計算
/home/sakaki/phonopy/ 計算待ち

計算おそすぎ
all.q@asura1a                  BIP   0/8/8          8.00     linux-x64     
   2764 0.50500 ag97       sakaki       r     01/08/2017 11:47:57     4        
   2765 0.50500 ag98       sakaki       r     01/08/2017 11:48:18     4        
---------------------------------------------------------------------------------
all.q@asura1b                  BIP   0/8/8          8.00     linux-x64     
   2761 0.50500 cu105      sakaki       r     01/08/2017 11:43:54     4        
   2762 0.50500 ag95       sakaki       r     01/08/2017 11:47:24     4        
-------------------------------------------------------------------------
コピーして別ので回しておく
SPOSCARで計算している　計算し直し

Ag96まで計算まわして

* Moment法
  * 線形結合　熱膨張，自由エネルギー
  * fcc構造
    * k,gamma
* 手法    
  * 計算アルゴリズム
  * ペアポテンシャルのパラメータ
  * vasp fitting
    * fittingの係数，精度
  * phonopy,phonon-DOS法説明
* 結果
  * 熱膨張
  * 自由エネルギー

au97まで計算
ag101エラー吐いてとまってたからバックアップとって計算投げなおし

phonopyの計算結果をe-rにするスクリプト
/Users/sakaki/Research/momentmethod/maple/data% ruby mk_er4phonopy.rb ~/vagrant/calc/Al/Al_ENCUT/TE/volume-temperature.dat

Aumedeaは精度を上げたが良い値をとらなかったもっと精度を上げる必要がある．

Cu103,Ag100とまってたag102,ag103

au100投げてないau103も
Cu103 計算精度下げて103_666て名前
ag103　８コアでなげてテスト
完了
Cu95-97 101-2
Ag95-98 101 104 105

Cu103-666は8581秒で計算おわった

sakaki@asura0:~/MM/Cu/unit_lattice_more
で計算精度をさらにあげてテストCu100
sakaki@asura0:~/MM/Cu/fullrelax_unit_accurateで計算精度あげて安定距離もテスト
unit_lattice_moreでCuのポテンシャル精度高いの計算中
Au-97投げなおし

momentmethodにグラフのプロットを楽にするplotdata.rbをつくる．

/Users/sakaki/Research/momentmethod/rubytestにPOTCARの読み込みのテストプログラムを置いとく

# phonopy Au106-109まで計算したが，107-109は値がおかしい
phononを確認すると負の値をとってる．．
とりあえず105の精度をあげて計算し直してみる
momentmethod_jにPOTをJにしたものを置いておく
ポテンシャルJで長さ10^-10mの計算完成
bundle exec exe/momentmethod sample_calc/jindo_Cu_J/ --potj

Maple typeset("",K^2,"")で指数などグラフの軸に書くことができる．

Au_105が再計算

gamma これみて論文に書く
testgamma1 = 4.0/3.0*@@potential.de4dr4(a1)+4.0*@@potential.de3dr3(a1)/a1+2.0*@@potential.de2dr2(a1)/(a1*a1)-2.0*@@potential.dedr(a1)/(a1*a1*a1)
testgamma2= 1.0/3.0*@@potential.de4dr4(a2)+4.0*@@potential.de3dr3(a2)/a2-4.0*@@potential.de2dr2(a2)/(a2*a2)+4.0*@@potential.dedr(a2)/(a2*a2*a2)
return gamma = testgamma1+testgamma2

有効桁数を変更
Digits:=20;

** プログラム内の結果表示はy0を越えてからの値を表示してしまっている．
large_aは修正したので参考にしてのちに実装

medea精度高いのAg100 Cu102103終わってない．

2.1e23..6e23で縦スケール
2.56e-10..2.6e-10横
