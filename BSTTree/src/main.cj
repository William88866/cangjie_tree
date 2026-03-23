package BSTTree

import std.collection.*

//---------------------------------------二叉搜索树------------------------------------
//二叉搜索树其递归定义为，左子节点小于父节点，右子节点大于父节点
//因此中序遍历就能从小到大排序，因此可以演变为二叉搜索树排序


//先定义树节点的类
public class Node_tree<T> where T <: Equal<T>{
    var val : T  
    var up:Option<Node_tree<T>> = None
    var left:Option<Node_tree<T>> = None
    var right:Option<Node_tree<T>> = None
    var count:Int64 = 0
    init(a:T){
        this.val = a
        this.up = None
        this.left = None
        this.right = None
        this.count = 1
    }
    public func nextLeft():?Node_tree<T>{
        return this.left
    }
    public func nextRight():?Node_tree<T>{
        return this.right
    }
    public func getVal():T{
        return this.val
    }
    public func getUp():?Node_tree<T>{
        return this.up
    }
}

//定义二叉搜索树
public class BSTTree<T> where T <: ToString&Greater<T>&Less<T>&LessOrEqual<T>&GreaterOrEqual<T>&Equal<T>{
    var root:?Node_tree<T> = None
    // 递归建树
    public init (data!:?Array<T> = None,recursion!:Bool){
        if (recursion){
            if (data.isSome()){
                for (i in data.getOrThrow()){
                    this.root = RInsert(i)
                }
            }
        }
    }
    // 迭代建树
    public init (data!:?Array<T> = None){
        if (data.isSome()){
            for (i in data.getOrThrow()){
                IInsert(i)
            }
        }
    }
    //写一个递归的插入
    public func RInsert(val:T,Nroot!:?Node_tree<T> = this.root):?Node_tree<T>{
        var tmp_root:?Node_tree<T> = Nroot
        if (tmp_root.isNone()){
            tmp_root = Node_tree<T>(val) 
        }
        else if(tmp_root.getOrThrow().val > val){
            tmp_root.getOrThrow().left = RInsert(val,Nroot:tmp_root.getOrThrow().left)
            tmp_root.getOrThrow().left.getOrThrow().up = tmp_root
        }
        else if (tmp_root.getOrThrow().val < val){
            tmp_root.getOrThrow().right = RInsert(val,Nroot:tmp_root.getOrThrow().right)
            tmp_root.getOrThrow().right.getOrThrow().up = tmp_root
        }
        return tmp_root  //返回其被修改的本身
    }
    //非递归的插入
    public func IInsert(val:T){
        if (this.root.isNone()){
            this.root = Node_tree<T>(val)
        }
        else{
            var node:?Node_tree<T> = this.root
            while(true){
                if (val < node.getOrThrow().val){
                    if (node.getOrThrow().left.isNone()){
                        node.getOrThrow().left = Node_tree<T>(val)
                        node.getOrThrow().left.getOrThrow().up = node
                        break
                    }
                    else{
                        node = node.getOrThrow().left
                    }
                }
                else if (val > node.getOrThrow().val){
                    if (node.getOrThrow().right.isNone()){
                        node.getOrThrow().right = Node_tree<T>(val)
                        node.getOrThrow().right.getOrThrow().up = node
                        break
                    }
                    else{
                        node = node.getOrThrow().right
                    }
                }
                else{
                    break
                }
            }
        }
    }
    //定义插入搜索树Node
    public func insertNode(Bnode:?Node_tree<T>,tat!:?Node_tree<T> = this.root){
        if (this.root.isNone()){
            this.root = Bnode
        }
        else{
            var node:?Node_tree<T> = tat
            while(true){
                if ( Bnode.getOrThrow().val < node.getOrThrow().val){
                    if (node.getOrThrow().left.isNone()){
                        node.getOrThrow().left = Bnode
                        node.getOrThrow().left.getOrThrow().up = node
                        break
                    }
                    else{
                        node = node.getOrThrow().left
                    }
                }
                else if (Bnode.getOrThrow().val > node.getOrThrow().val){
                    if (node.getOrThrow().right.isNone()){
                        node.getOrThrow().right = Bnode
                        node.getOrThrow().right.getOrThrow().up = node
                        break
                    }
                    else{
                        node = node.getOrThrow().right
                    }
                }
                else{
                    break
                }
            }
        }
    }
    //定义查找
    public func contains(val:T):Bool{
        var node = this.root
        while(true){
            if (node.isSome()){
                if (node.getOrThrow().val == val){
                    return true
                }
                else if (node.getOrThrow().val > val){
                    node = node.getOrThrow().left
                }
                else if (node.getOrThrow().val < val){
                    node = node.getOrThrow().right
                }
            }
            else{
                return false
            }
        }
        return false
    }
    //定义查找返回
    public func getNode(val:T,tat!:?Node_tree<T> = this.root):?Node_tree<T>{
        var node = tat
        while(true){
            if (node.isSome()){
                if (node.getOrThrow().val == val){
                    return node
                }
                else if (node.getOrThrow().val > val){
                    node = node.getOrThrow().left
                }
                else if (node.getOrThrow().val < val){
                    node = node.getOrThrow().right
                }
            }
            else{
                return None
            }
        }
        return None
    }
    //定义删除叶节点（空根节点也算叶节点）
    public func remove_01(node:?Node_tree<T>){
        if (node.getOrThrow().up.isNone()){
            this.root = None
            return
        }
        if (node.getOrThrow().up.getOrThrow().left.isSome()){
            if (node.getOrThrow().up.getOrThrow().left.getOrThrow().val == node.getOrThrow().val ){
                node.getOrThrow().up.getOrThrow().left = None
                node.getOrThrow().up = None
                return
            }
        }
        if (node.getOrThrow().up.getOrThrow().right.isSome()){
            if (node.getOrThrow().up.getOrThrow().right.getOrThrow().val == node.getOrThrow().val ){
                node.getOrThrow().up.getOrThrow().right = None
                node.getOrThrow().up = None
                return
            }
        }
        return
    }
    //定义只有一个子节点的删除
    public func remove_02(node:?Node_tree<T>){
        if (node.getOrThrow().up.isNone()){
            if (node.getOrThrow().left.isSome()){
                this.root = node.getOrThrow().left
                return
            }
            else{
                this.root = node.getOrThrow().right
                return
            }
        }
        if (node.getOrThrow().up.getOrThrow().left.isSome()){
            if (node.getOrThrow().up.getOrThrow().left.getOrThrow().val == node.getOrThrow().val){
                if (node.getOrThrow().left.isSome()){
                    node.getOrThrow().up.getOrThrow().left = None
                    insertNode(node.getOrThrow().left)
                    return
                }
                else if (node.getOrThrow().right.isSome()){
                    node.getOrThrow().up.getOrThrow().left = None
                    insertNode(node.getOrThrow().right)
                    return
                }
            }
        }
        if (node.getOrThrow().up.getOrThrow().right.isSome()){
            if (node.getOrThrow().up.getOrThrow().right.getOrThrow().val == node.getOrThrow().val){
                if (node.getOrThrow().left.isSome()){
                    node.getOrThrow().up.getOrThrow().right = None
                    insertNode(node.getOrThrow().left)
                    return
                }
                else if (node.getOrThrow().right.isSome()){
                    node.getOrThrow().up.getOrThrow().right = None
                    insertNode(node.getOrThrow().right)
                    return
                }
            }
        }
    }
    // 定义查找右子树的最小值，并返回其节点
    public func getRightMin(node:?Node_tree<T>):?Node_tree<T>{
        var tmp = node.getOrThrow().right
        while(true){
            if (tmp.getOrThrow().left.isSome()){
                tmp = tmp.getOrThrow().left
            }
            else if (tmp.getOrThrow().left.isNone()){
                return tmp
            }
        }
        return None
    }

    //开始合并所有删除，汇总成remove
    //其包含删除含有两个子树节点的递归形式
    public func remove(val:T,tat!:?Node_tree<T> = this.root):Unit{
        var targetNode = getNode(val,tat:tat)
        if (targetNode.isNone()){
            return ()
        }
        if (targetNode.getOrThrow().left.isNone()&&targetNode.getOrThrow().right.isNone()){
            remove_01(targetNode)
            return
        }
        else if ((targetNode.getOrThrow().left.isSome()&&targetNode.getOrThrow().right.isNone())||
        (targetNode.getOrThrow().left.isNone()&&targetNode.getOrThrow().right.isSome())){
            remove_02(targetNode)
            return
        }
        else if (targetNode.getOrThrow().left.isSome()&&targetNode.getOrThrow().right.isSome()){
            var rightMin = getRightMin(targetNode)
            targetNode.getOrThrow().val = rightMin.getOrThrow().val
            remove(rightMin.getOrThrow().val,tat:rightMin)
        }
    }







    //---------------遍历---------------

    //1前序遍历
    public func firIter(tmp!:ArrayList<T> = ArrayList<T>([]),node!:?Node_tree<T> = this.root):ArrayList<T>{
        if (node.isSome()){
            tmp.add(node.getOrThrow().val)
            // println(node.getOrThrow().val)
            firIter(tmp:tmp,node:node.getOrThrow().left)
            firIter(tmp:tmp,node:node.getOrThrow().right)
        }
        return tmp
    }

    //2 中序遍历
    public func midIter(tmp!:ArrayList<T> = ArrayList<T>([]),node!:?Node_tree<T> = this.root):ArrayList<T>{
        if (node.isSome()){
            midIter(tmp:tmp,node:node.getOrThrow().left)
            tmp.add(node.getOrThrow().val)
            // println(node.getOrThrow().val)
            midIter(tmp:tmp,node:node.getOrThrow().right)
        }
        return tmp
    }

    //后序遍历
    public func endIter(tmp!:ArrayList<T> = ArrayList<T>([]),node!:?Node_tree<T> = this.root):ArrayList<T>{
        if (node.isSome()){
            endIter(tmp:tmp,node:node.getOrThrow().left)
            endIter(tmp:tmp,node:node.getOrThrow().right)
            tmp.add(node.getOrThrow().val)
            // println(node.getOrThrow().val)
        }
        return tmp
    }




}












main(): Int64 {
    // var a = ArrayList<Int64>([5,3,2,1,4,8,9,6,7,6,10,8,14,13,15,11,12])
    var tree = BSTTree<Int64>(data:[5,3,2,1,4,8,9,6,7,6,10,8,14,13,15,11,12])
    // println(tree.root.getOrThrow().getVal())
    // println(tree.root.getOrThrow().nextLeft().getOrThrow().getVal())
    // println(tree.root.getOrThrow().nextRight().getOrThrow().getVal())
    // println(tree.root.getOrThrow().nextLeft().getOrThrow().nextLeft().getOrThrow().getVal())
    // println(tree.root.getOrThrow().nextLeft().getOrThrow().nextLeft().getOrThrow().up.getOrThrow().val) //测试根的父节点
    // // println(tree.root.getOrThrow().nextLeft().getOrThrow().nextRight().getOrThrow().getVal())
    println(tree.midIter())
    println(tree.contains(8))
    println(tree.contains(5))
    println(tree.contains(6))
    println(tree.contains(3))
    println(tree.contains(2))
    println(tree.contains(9))
    println(tree.contains(7))
    println(tree.contains(1))
    println(tree.contains(4))
    println(tree.contains(0))
    println(tree.contains(10))
    var fir = tree.getNode(5)
    println(fir.getOrThrow().val)
    println(fir.getOrThrow().left.getOrThrow().val)  //look at this,the memory always contain it
    println('-------------------------------remove---------------------------')
    print('first:  ');println(tree.firIter())
    print('mid:    ');println(tree.midIter())
    print('end:    ');println(tree.endIter())
    tree.remove(1)
    tree.remove(6)
    tree.remove(8)
    tree.remove(2)
    tree.remove(3)
    tree.remove(4)
    tree.remove(5)
    tree.remove(6)
    tree.remove(7)
    // println(tree.root.getOrThrow().right.getOrThrow().right.getOrThrow().right.getOrThrow().right.getOrThrow().val)

    println(tree.midIter())

    return 0
}