# coding: utf-8

import numpy as np
import csv
from collections import OrderedDict

def getNearestValue(list, num):
    """
    概要: リストからある値に最も近い値を返却する関数
    @param list: データ配列
    @param num: 対象値
    @return 対象値に最も近い値
    """

    # リスト要素と対象値の差分を計算し最小値のインデックスを取得
    l = np.abs(np.asarray(list) - num)
    idx = np.where(l == l.min())
    out_list = []
    for i in range(idx[0].size):
        out_list.append(list[idx[0][i]])
    print out_list
    return out_list

if __name__ == "__main__":

    output_point_list = []
    point = [20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
    # csv読み込み
    with open('input.csv', 'r') as inf:
        reader = csv.reader(inf)
        header = next(reader)

        for row in reader:
            less_answer_dic = dict(zip(header, row))
            point_dic = dict(zip(header, row))
            point_dic.pop("Answer")
            answer_value = less_answer_dic.pop("Answer")

            rowf = map(float, less_answer_dic.values());
            rowf_uniq = list(set(rowf))

            j = 0
            for i in range(len(rowf_uniq)):
                if len(rowf_uniq) == 0:
                    break
                nearest_value_list = getNearestValue(rowf_uniq, int(answer_value))
                
                #近似値がどのチームか判定
                duplication_count = 0
                for nearest_value in nearest_value_list:
                    for team, value in less_answer_dic.items():
                        if float(value) == nearest_value:
                            point_dic[team] = point[j]
                            duplication_count += 1
                    rowf_uniq.remove(nearest_value)
                j += duplication_count
                
            output_point_list.append(point_dic)

    with open('output.csv', 'w') as outf:
        writer = csv.writer(outf, lineterminator='\n') # 改行コード（\n）を指定しておく
        writer.writerow(header)
        for output_dic in output_point_list:
            output_dic = sorted(output_dic.items())
            output_list = []
            for output_tuple in output_dic:
                output_list.append(output_tuple[1])
            writer.writerow(output_list)
